{ pkgs, inputs, system, ... }:

{
  imports = [
    ./dunst.nix
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
  };

  services = {
    picom = import ./picom.nix;
    redshift = import ./redshift.nix;
    screen-locker = {
      enable = true;
      xautolock.enable = false;
      lockCmd = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
    };
  };

  xsession = {
    enable = true;
    numlock.enable = true;
    pointerCursor = {
      package = pkgs.bibata-extra-cursors;
      name = "Bibata DarkRed";
    };
    windowManager.command = "${pkgs.spectrwm}/bin/spectrwm";
  };
}
