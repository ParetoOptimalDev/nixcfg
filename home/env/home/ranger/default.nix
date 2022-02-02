{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.home.ranger;

in

{
  options = {
    custom.env.home.ranger = {
      enable = mkEnableOption "Ranger config";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.ranger = {
      enable = true;
      bookmarks = ''
        # Home
        s:/mnt/home/home/Scan
        p:/mnt/home/public
      '';
    };
  };
}
