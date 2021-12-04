{ pkgs, inputs, system, ... }:

{
  imports = [
    ./env/home
    ./modules
    ./roles/common
    ./roles/desktop
    ./roles/gaming
    ./roles/graphics
    ./roles/multimedia
    ./roles/office
    ./roles/ops
  ];

  xdg.configFile = {
    "spectrwm/initscreen.sh" = {
      text = ''
        #!/usr/bin/env bash
        xrandr --output DP-4 --rate 144 --mode 1920x1080 --output HDMI-0 --off
      '';
      executable = true;
    };
  };
}
