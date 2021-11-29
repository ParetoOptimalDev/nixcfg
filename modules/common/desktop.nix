{ config, pkgs, ... }:

{
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
