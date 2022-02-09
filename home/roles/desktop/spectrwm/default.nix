{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop.spectrwm;
  lockerCfg = config.custom.roles.desktop.locker;

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

        locker = {
          inherit (lockerCfg) package lockCmd;
        };
      };
      roles.desktop = {
        locker.enable = true;
      };
    };
  };
}
