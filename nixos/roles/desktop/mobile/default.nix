{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop.mobile;

in

{
  options = {
    custom.roles.desktop.mobile = {
      enable = mkEnableOption "Mobile computer config";
    };
  };

  config = mkIf cfg.enable {
    services = {
      logind.lidSwitch = "suspend-then-hibernate";
      upower.enable = true;
    };
  };
}
