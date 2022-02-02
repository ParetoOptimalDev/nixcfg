{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.home;

in

{
  options = {
    custom.env.home = {
      enable = mkEnableOption "Home environment";
    };
  };

  config = mkIf cfg.enable {

    custom = {
      env.home = {
        git.enable = true;
        office.cli.enable = config.custom.roles.office.cli.enable;
        ranger.enable = true;
      };

      roles = {
        desktop = {
          cursors.pointerCursorName = "Bibata-Modern-DodgerBlue";
        };
      };
    };
  };
}
