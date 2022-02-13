{ config, lib, pkgs, ... }:

with lib;

let

  desktopCfg = config.custom.roles.desktop;
  cfg = desktopCfg.spectrwm;

in

{
  options = {
    custom.roles.desktop.spectrwm = {
      enable = mkEnableOption "Spectrwm window manager";
    };
  };

  config = mkIf cfg.enable {
    custom = {
      programs.spectrwm = {
        autoruns = {
          "alacritty" = 1;
        };
        font = {
          inherit (desktopCfg.font) package xft;
        };
        locker = {
          inherit (desktopCfg.locker) package lockCmd;
        };
      };
      roles.desktop = {
        locker.enable = true;
      };
    };
  };
}
