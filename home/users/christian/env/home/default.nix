{ config, lib, ... }:

with lib;

let

  programsCfg = config.custom.programs;
  rolesCfg = config.custom.roles;
  userCfg = config.custom.users.christian;
  cfg = userCfg.env.home;

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
        firefox.enable = programsCfg.firefox.enable;
        git.enable = userCfg.git.enable;
        office.cli.enable = rolesCfg.office.cli.enable;
        ranger.enable = userCfg.ranger.enable;
        xmonad.enable = programsCfg.xmonad.enable;
      };

      roles = {
        desktop = {
          cursors.pointerCursorName = "Bibata-Modern-DodgerBlue";
        };
      };
    };
  };
}
