{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password
    _1password-gui
    bind
    wget
    thunderbird

    # Messengers
    signal-desktop
    tdesktop # Telegram
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
    qutebrowser.enable = true;
  };

  services = {
    nextcloud-client = import ./nextcloud-client;
  };
}
