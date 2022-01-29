{ config, lib, ... }:

with lib;

let

  cfg = config.custom.desktop.mobile;

in

{
  options = {
    custom.desktop.mobile = {
      enable = mkEnableOption "Enable laptop specific settings";
    };
  };

  config = mkIf cfg.enable {
    services = {
      logind.lidSwitch = "suspend-then-hibernate";
      upower.enable = true;
    };
  };
}
