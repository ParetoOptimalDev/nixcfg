{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.dev.js;

in

{
  options = {
    custom.roles.dev.js = {
      enable = mkEnableOption "Javascript";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.spidermonkey_91 # REPL
    ];
  };
}
