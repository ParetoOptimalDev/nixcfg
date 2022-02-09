{ config, pkgs, ... }:

{
  custom.roles.desktop.grobi = {
    rules = [
      {
        name = "Single";
        outputs_connected = [ "DP-2" ];
        outputs_disconnected = [ "DP-0" "DP-1" "HDMI-0" ];
        configure_single = "DP-2";
        primary = "DP-2";
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --mode 1920x1080 --rate 60"
          "${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --panning 1920x1080+0+0"
        ];
      }
      {
        name = "Home-Office";
        outputs_connected = [ "DP-2" "HDMI-0-BNQ-32554-21573-ZOWIE XL LCD-5AG00657SL0" ];
        outputs_disconnected = [ "DP-0" "DP-1" ];
        configure_row = [ "HDMI-0" "DP-2" ];
        primary = "HDMI-0";
        atomic = true;
      }
      {
        name = "Fallback";
        configure_single = "DP-2";
      }
    ];
  };
}
