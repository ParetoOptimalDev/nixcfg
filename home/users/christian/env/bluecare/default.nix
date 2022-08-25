{ config, lib, pkgs, ... }:

with lib;

let

  programsCfg = config.custom.programs;
  rolesCfg = config.custom.roles;
  userCfg = config.custom.users.christian;
  cfg = userCfg.env.bluecare;

in

{
  options = {
    custom.users.christian.env.bluecare = {
      enable = mkEnableOption "BlueCare environment";

      userEmail = mkOption {
        type = types.str;
        default = "christian.harke@bluecare.ch";
        description = "User e-mail address";
      };
    };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      robo3t
      slack
      teams
    ];

    custom = {
      users.christian.env.bluecare = {
        bin.enable = true;
        davmail.enable = true;
        firefox.enable = programsCfg.firefox.enable;
        git.enable = userCfg.git.enable;
        gtk.enable = rolesCfg.desktop.enable;
        office.cli.enable = rolesCfg.office.cli.enable;
        ranger.enable = userCfg.ranger.enable;
        scala.enable = rolesCfg.dev.scala.enable;
        ssh.enable = config.programs.ssh.enable;
        tmux.enable = programsCfg.tmux.enable;
        xmonad.enable = programsCfg.xmonad.enable;
        zoomus.enable = true;
      };

      roles = {
        desktop = {
          cursors.pointerCursorName = "Bibata-Modern-DarkRed";
        };
        ops.enable = true;
      };
    };
  };
}
