{ config, ... }:

{
  programs.spectrwm = {
    autoruns = {
      "${config.xdg.configFile."spectrwm/initscreen.sh".target}" = 1;
      "firefox" = 3;
      "steam" = 9;
      "ts3client" = 10;
    };
    initscrScript = ''
      xrandr --output DP-4 --rate 144 --mode 1920x1080 --output HDMI-0 --off
    '';
  };
}
