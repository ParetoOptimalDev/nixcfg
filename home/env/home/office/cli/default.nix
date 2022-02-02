{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.home.office.cli;

in

{
  options = {
    custom.env.home.office.cli = {
      enable = mkEnableOption "CLI office config";
    };
  };

  config = mkIf cfg.enable {
    custom.roles.office.cli = {
      khal.extraConfig = ''
        [calendars]

        [[private]]
        path = ${config.xdg.dataHome}/calendars/nextcloud/personal
        color = dark red

        [default]
        highlight_event_days = True
        default_calendar = private
      '';
    };
  };
}
