{ config, pkgs, ... }:

{
  services = {
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
