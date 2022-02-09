{ config, pkgs, ... }:

{
  custom.roles.desktop.grobi = {
    rules = [
      {
        name = "DP-Single";
        outputs_connected = [ "DP-4-BNQ-32555-21573-ZOWIE XL LCD-5AG00657SL0" ];
        outputs_disconnected = [ "DVI-I-0" "DVI-I-1" "DP-0" "DP-1" "DP-2" "DP-3" ];
        configure_single = "DP-4";
        primary = "DP-4";
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --mode 1920x1080 --rate 144"
        ];
      }
      {
        name = "HDMI-Single";
        outputs_connected = [ "HDMI-0-BNQ-32554-21573-ZOWIE XL LCD-5AG00657SL0" ];
        outputs_disconnected = [ "DVI-I-0" "DVI-I-1" "DP-0" "DP-1" "DP-2" "DP-3" "DP-4" ];
        configure_single = "HDMI-0";
        primary = "HDMI-0";
        atomic = true;
      }
      {
        name = "Fallback";
        configure_single = "DP-4";
      }
    ];
  };
}
