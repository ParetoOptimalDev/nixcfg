{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.home.firefox;

in

{
  options = {
    custom.users.christian.env.home.firefox = {
      enable = mkEnableOption "Firefox config";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.firefox.homepage = "https://harke.ch/dash/home/";
  };
}
