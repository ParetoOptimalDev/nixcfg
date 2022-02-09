{ config, lib, ... }:

with lib;

let

  bluecareCfg = config.custom.users.christian.env.bluecare;
  cfg = bluecareCfg.office.cli;

in

{
  options = {
    custom.users.christian.env.bluecare.office.cli = {
      enable = mkEnableOption "CLI office config";

      caldav = {
        host = mkOption {
          type = types.str;
          default = "localhost";
          description = "CalDav server";
        };

        port = mkOption {
          type = types.int;
          default = 1080;
          description = "CalDav port";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    custom.roles.office.cli = {
      khal.extraConfig = ''
        [calendars]

        [[private]]
        path = ${config.xdg.dataHome}/calendars/nextcloud/personal
        color = dark red

        [[work]]
        path = ${config.xdg.dataHome}/calendars/bluecare/calendar
        color = dark blue

        [default]
        highlight_event_days = True
        default_calendar = work
      '';
      vdirsyncer.extraConfig = ''
        # CALDAV

        [pair bc_calendar]
        a = "bc_calendar_local"
        b = "bc_calendar_remote"
        collections = ["from a", "from b"]
        metadata = ["displayname", "color"]
        conflict_resolution = "b wins"

        [storage bc_calendar_local]
        type = "filesystem"
        path = "${config.xdg.dataHome}/calendars/bluecare"
        fileext = ".ics"

        [storage bc_calendar_remote]
        type = "caldav"
        read_only = true
        url = "http://${cfg.caldav.host}:${toString cfg.caldav.port}/users/${bluecareCfg.userEmail}/calendar/"
        username.fetch = ["command", "~/.accounts/bluecare/get_user.sh"]
        password.fetch = ["command", "~/.accounts/bluecare/get_pass.sh"]
      '';
    };
  };
}
