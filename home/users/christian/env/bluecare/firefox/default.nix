{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.firefox;

in

{
  options = {
    custom.users.christian.env.bluecare.firefox = {
      enable = mkEnableOption "Firefox config";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.firefox = {
      homepage = "https://harke.ch/dash/work/";
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        header-editor
      ];
    };
  };
}
