{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.env.bluecare;

in

{
  options = {
    custom.env.bluecare = {
      enable = mkEnableOption "BlueCare environment";

      username = mkOption {
        type = types.str;
        description = "User name";
      };
    };
  };

  config = mkIf cfg.enable {
    custom = {
      env.bluecare = {
        fileserverMounts.enable = true;
        openvpn.enable = true;
      };

      programs = {
        docker.enable = true;
        virtualbox.enable = true;
      };
    };
  };
}
