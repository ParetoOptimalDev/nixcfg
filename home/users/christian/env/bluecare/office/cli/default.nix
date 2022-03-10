{ config, lib, pkgs, ... }:

with lib;

let

  bluecareCfg = config.custom.users.christian.env.bluecare;
  cfg = bluecareCfg.office.cli;

  calendarsPath = "${config.xdg.dataHome}/calendars";

  inherit (config.custom.roles.homeage) secretsPath;
  secretUrl = "vdirsyncer-nextcloud-url";
  secretUsername = "vdirsyncer-bluecare-username";
  secretPassword = "vdirsyncer-bluecare-password";

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
    custom.roles = {
      homeage.secrets = [
        secretUrl
        secretUsername
        secretPassword
      ];

      office.cli = {
        khal.extraConfig = ''
          [calendars]

          [[private]]
          path = ${calendarsPath}/nextcloud/personal
          color = dark red

          [[work]]
          path = ${calendarsPath}/bluecare/calendar
          color = dark blue

          [default]
          highlight_event_days = True
          default_calendar = work
        '';
        vdirsyncer.extraConfig = ''
          # CALDAV WORK

          [pair bc_calendar]
          a = "bc_calendar_local"
          b = "bc_calendar_remote"
          collections = ["from a", "from b"]
          metadata = ["displayname", "color"]
          conflict_resolution = "b wins"

          [storage bc_calendar_local]
          type = "filesystem"
          path = "${calendarsPath}/bluecare"
          fileext = ".ics"

          [storage bc_calendar_remote]
          type = "caldav"
          read_only = true
          url = "http://${cfg.caldav.host}:${toString cfg.caldav.port}/users/${bluecareCfg.userEmail}/calendar/"
          username.fetch = ["command", "${pkgs.coreutils}/bin/cat", "${secretsPath}/${secretUsername}"]
          password.fetch = ["command", "${pkgs.coreutils}/bin/cat", "${secretsPath}/${secretPassword}"]
        '';
      };
    };
  };
}
