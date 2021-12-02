{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = true;
    };
  };
}
