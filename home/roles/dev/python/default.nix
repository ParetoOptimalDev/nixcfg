{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.dev.python;

in

{
  options = {
    custom.roles.dev.python = {
      enable = mkEnableOption "Python";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.python3
    ];
  };
}
