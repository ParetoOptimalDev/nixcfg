{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.env.bluecare;

in

{
  options = {
    custom.env.bluecare = {
      enable = mkEnableOption "BlueCare environment";
    };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      robo3t
      slack
      teams
    ];

    custom = {
      env.bluecare = {
        bin.enable = true;
        davmail.enable = true;
        git.enable = true;
        office.cli.enable = config.custom.roles.office.cli.enable;
        ranger.enable = true;
        scala.enable = config.custom.roles.dev.scala.enable;
        ssh.enable = true;
        tmux.enable = true;
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
