{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.home.git;

in

{
  options = {
    custom.env.home.git = {
      enable = mkEnableOption "Git config";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      userEmail = "christian@harke.ch";
    };
  };
}
