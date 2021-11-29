{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  services = {
    autorandr.enable = true;

    xserver = {
      enable = true;
      desktopManager.xterm.enable = true;
      displayManager.lightdm.greeters.mini = {
        enable = true;
        user = import ../../username.nix;
      };
    };
  };
}
