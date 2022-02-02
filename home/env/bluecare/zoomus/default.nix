{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.zoomus;

in

{
  options = {
    custom.env.bluecare.zoomus = {
      enable = mkEnableOption "Zoom config";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.unstable.zoom-us
    ];

    xdg.configFile."zoomus.conf".source = ./config/zoomus.conf;
  };
}
