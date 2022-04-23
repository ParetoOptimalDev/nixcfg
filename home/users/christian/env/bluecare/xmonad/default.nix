{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.xmonad;

in

{
  options = {
    custom.users.christian.env.bluecare.xmonad = {
      enable = mkEnableOption "Xmonad config";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.xmonad = {
      autoruns = {
        "gnome-pomodoro" = 1;
        "idea-ultimate" = 2;
        "firefox" = 3;
        "slack" = 4;
        "chromium https://mail.bluecare.ch/owa/" = 5;
      };
    };
  };
}
