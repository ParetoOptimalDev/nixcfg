{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop;

in

{
  options = {
    custom.roles.desktop = {
      enable = mkEnableOption "Desktop";
    };
  };

  config = mkIf cfg.enable {

    custom.roles.desktop = {
      alacritty.enable = true;
      cursors.enable = true;
      dunst.enable = true;
      gtk.enable = true;
      picom.enable = true;
      redshift.enable = true;
      xmonad.enable = true;
    };

    home = {
      packages = with pkgs; [
        gnome.pomodoro
        mupdf
        peek
        gifski
        xclip
        xzoom
      ];
    };

    xsession = {
      enable = true;
      numlock.enable = true;
    };
  };
}
