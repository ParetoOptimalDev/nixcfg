{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.hardware.kmonad;

in

{
  options = {
    custom.users.christian.hardware.kmonad = {
      enable = mkEnableOption "Kmonad service";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.kmonad = {
      enable = true;
      configFiles = {
        G512 = ./logitech-g512.de-ch.kbd;
        WASD_V3 = ./wasd-v3.de-ch.kbd;
      };
    };
  };
}
