{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.home;

in

{
  options = {
    custom.users.christian.env.home = {
      enable = mkEnableOption "Home environment";
    };
  };

  config = mkIf cfg.enable {

    custom = {
      users.christian.env.home = {
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
