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
      gtk.enable = true;
      redshift.enable = true;
      xmonad.enable = true;
    };

    home = {
      packages = with pkgs; [
        # Locker
        i3lock-pixeled

        # Misc
        gnome.pomodoro
        mupdf
        peek
        gifski
        xclip
        xzoom
      ];
    };

    services = {
      screen-locker = {
        enable = true;
        xautolock.enable = false;
        lockCmd = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
      };
    };

    xsession = {
      enable = true;
      numlock.enable = true;
    };
  };
}
