{ config, lib, pkgs, ... } @ args:

with lib;

let

  cfg = config.custom.roles.desktop;

in

{
  options = {
    custom.roles.desktop = {
      enable = mkEnableOption "Desktop computer config";
    };
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        desktopManager.xterm.enable = true;
      };
    };
  };
}
