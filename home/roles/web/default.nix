{ config, pkgs, ... }:

{
  imports = [
    ./nextcloud-client
  ];

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
}
