{ pkgs, inputs, system, ... }:

{
  home = {
    packages = with pkgs; [
      # Desktop dependencies
      acpi
      dmenu
      i3lock-pixeled
      libnotify
      lm_sensors
      scrot
      spectrwm
    ];
  };

  programs = {
    feh.enable = true;
  };

  services = {
    dunst = import ./dunst.nix { inherit pkgs; };
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
