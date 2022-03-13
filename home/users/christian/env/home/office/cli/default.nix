{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.home.office.cli;

  calendarsPath = "${config.xdg.dataHome}/calendars";

in

{
  options = {
    custom.users.christian.env.home.office.cli = {
      enable = mkEnableOption "CLI office config";
    };
  };

  config = mkIf cfg.enable {
    custom.roles.office.cli = {
      khal.extraConfig = ''
        [calendars]

        [[private]]
        path = ${calendarsPath}/nextcloud/personal
        color = dark red

        [default]
        highlight_event_days = True
        default_calendar = private
      '';
    };
  };
}
