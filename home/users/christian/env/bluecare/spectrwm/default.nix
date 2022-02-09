{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.spectrwm;

in

{
  options = {
    custom.users.christian.env.bluecare.spectrwm = {
      enable = mkEnableOption "Spectrwm config";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.spectrwm = {
      enable = true;
      autoruns = {
        "gnome-pomodoro" = 1;
        "idea-ultimate" = 2;
        "firefox" = 3;
        "slack" = 4;
        "zoom" = 4;
        "chromium https://mail.bluecare.ch/owa/" = 5;
      };
    };
  };
}
