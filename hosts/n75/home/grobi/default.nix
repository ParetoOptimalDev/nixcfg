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
        name = "Office-0";
        outputs_connected = [ "DP-2" "DP-0.8" "DP-0.1" ];
        outputs_disconnected = [ "DP-0" "DP-1" "HDMI-0" ];
        configure_row = [ "DP-2" "DP-0.8" "DP-0.1" ];
        primary = "DP-0.8";
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --auto --output DP-0.8 --auto --primary --above DP-2 --output DP-0.1 --auto --right-of DP-0.8"
        ];
      }
      {
        name = "Office-1";
        outputs_connected = [ "DP-2" "DP-1.8" "DP-1.1" ];
        outputs_disconnected = [ "DP-0" "DP-1" "HDMI-0" ];
        configure_row = [ "DP-2" "DP-1.8" "DP-1.1" ];
        primary = "DP-1.8";
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --auto --output DP-1.8 --auto --primary --above DP-2 --output DP-1.1 --auto --right-of DP-1.8"
        ];
      }
      {
        name = "Fallback";
        configure_single = "DP-2";
      }
    ];
  };
}
