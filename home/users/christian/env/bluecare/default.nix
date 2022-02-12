{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare;

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
        git.enable = true;
        office.cli = {
          enable = config.custom.roles.office.cli.enable;
          caldav = {
            host = "localhost";
            port = config.custom.programs.davmail.config.davmail.caldavPort;
          };
        };
        ranger.enable = true;
        scala.enable = config.custom.roles.dev.scala.enable;
        ssh.enable = true;
        tmux.enable = true;
        xmonad.enable = true;
        zoomus.enable = true;
      };

      roles = {
        desktop = {
          cursors.pointerCursorName = "Bibata-Modern-DarkRed";
        };
      };
    };
  };
}
