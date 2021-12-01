{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Audio control
    alsa-lib
    playerctl

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
