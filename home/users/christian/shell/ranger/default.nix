{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.shell.ranger;

in

{
  options = {
    custom.users.christian.shell.ranger = {
      enable = mkEnableOption "Ranger file manager";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ranger
    ];

    xdg.dataFile."ranger/bookmarks".text = ''
      # Common
      d:${config.home.homeDirectory}/Downloads
      h:/mnt/home/home
    '';
  };
}
