{ pkgs, inputs, system, ... }:

{
  imports = [
    ../dunst
  ];

  home = {
    packages = with pkgs; [
      # Baraction dependencies
      acpi
      lm_sensors
      scrot

      # Menu
      dmenu

      # Locker
      i3lock-pixeled

      # Fonts
      nerdfonts

      # The window manager
      spectrwm
    ];
  };

  programs = {
    feh.enable = true;
    spectrwm = {
      autoruns = {
        "alacritty" = 1;
      };
    };
  };

  services = {
    picom = import ../picom;
  };

  xsession = {
    enable = true;
    windowManager.command = "${pkgs.spectrwm}/bin/spectrwm";

    initExtra = ''
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize ~/Pictures/wallpapers
    '';
  };
}
