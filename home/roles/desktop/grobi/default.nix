{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop.grobi;

in

{
  options = {
    custom.roles.desktop.grobi = {
      enable = mkEnableOption "Grobi config";

      rules = mkOption {
        type = with types; listOf attrs;
        default = [ ];
        description = "Grobi rules";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      feh
      grobi
      xorg.xrandr
    ];

    services.grobi = {
      inherit (cfg) rules;
      enable = true;
      executeAfter = [
        "${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize $HOME/Pictures/wallpapers"
      ];
    };
  };
}
