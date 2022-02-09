{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.programs.ranger;

in

{
  options = {
    custom.programs.ranger = {
      enable = mkEnableOption "Ranger";

      bookmarks = mkOption {
        type = types.str;
        default = "";
        description = "Bookmarks to be added";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ranger
    ];

    xdg.dataFile."ranger/bookmarks".text = cfg.bookmarks;
  };
}
