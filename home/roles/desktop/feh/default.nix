{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop.feh;

in

{
  options = {
    custom.roles.desktop.feh = {
      enable = mkEnableOption "Feh image and background util";

      wallpapersDir = mkOption {
        type = types.path;
        default = config.home.homeDirectory + "/Pictures/wallpapers";
        description = "Directory containing wallpapers";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.feh.enable = true;

    xsession.initExtra = ''
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize ${cfg.wallpapersDir}
    '';
  };
}
