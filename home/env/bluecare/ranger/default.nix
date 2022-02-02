{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.ranger;

in

{
  options = {
    custom.env.bluecare.ranger = {
      enable = mkEnableOption "Ranger config";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.ranger = {
      enable = true;
      bookmarks = ''
        # BlueCare
        H:/mnt/bluecare/home
        t:/mnt/bluecare/transfer
        T:/mnt/bluecare/transfer
      '';
    };
  };
}
