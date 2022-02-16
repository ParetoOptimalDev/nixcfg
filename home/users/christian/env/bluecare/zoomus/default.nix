{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.zoomus;

in

{
  options = {
    custom.users.christian.env.bluecare.zoomus = {
      enable = mkEnableOption "Zoom config";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zoom-us
    ];

    xdg.configFile."zoomus.conf".source = ./config/zoomus.conf;
  };
}
