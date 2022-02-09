{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.home.git;

in

{
  options = {
    custom.users.christian.env.home.git = {
      enable = mkEnableOption "Git config";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      userEmail = "christian@harke.ch";
    };
  };
}
