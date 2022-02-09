{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.web.nextcloud-client;

in

{
  options = {
    custom.roles.web.nextcloud-client = {
      enable = mkEnableOption "Nextcloud client";
    };
  };

  config = mkIf cfg.enable {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}
