{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.home.xmonad;

in

{
  options = {
    custom.users.christian.env.home.xmonad = {
      enable = mkEnableOption "Xmonad config";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.xmonad = {
      autoruns = {
        "firefox" = 3;
        "steam" = 9;
        "ts3client" = 10;
      };
    };
  };
}
