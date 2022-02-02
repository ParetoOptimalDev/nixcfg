{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop.spectrwm;

in

{
  options = {
    custom.roles.desktop.spectrwm = {
      enable = mkEnableOption "Spectrwm window manager";
    };
  };

  config = mkIf cfg.enable {
    custom = {
      programs.spectrwm.autoruns = {
        "alacritty" = 1;
      };
      roles.desktop = {
        dunst.enable = true;
        feh.enable = true;
        picom.enable = true;
      };
    };
  };
}
