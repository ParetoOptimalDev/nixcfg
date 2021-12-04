{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Audio control
    alsa-lib
    playerctl

    # Backlight control
    xorg.xbacklight
    kbdlight

    # Terminal
    alacritty

    # Calculator
    eva

    # Explorer
    ranger

    # Browser
    firefox

    xbindkeys
  ];

  xdg.configFile."xbindkeysrc" = {
    source = ./config/xbindkeysrc;
    target = config.home.homeDirectory + "/.xbindkeysrc";
  };

  xsession.initExtra = ''
    xbindkeys
  '';
}
