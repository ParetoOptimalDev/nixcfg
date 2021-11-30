{ pkgs, inputs, system, ... }:

{
  imports = [
    ../dunst.nix
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
    picom = import ../picom.nix;
  };

  xdg.configFile =
    let
      binaryName = "spectrwm";
      reloadCmd = "killall -HUP ${binaryName}";
    in
    {
      "${binaryName}/baraction.sh" = {
        source = ./config/baraction.sh;
        executable = true;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/batt.sh" = {
        source = ./config/baraction/batt.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/headset.sh" = {
        source = ./config/baraction/headset.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/cpu.sh" = {
        source = ./config/baraction/cpu.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/datetime.sh" = {
        source = ./config/baraction/datetime.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/hdd.sh" = {
        source = ./config/baraction/hdd.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/mem.sh" = {
        source = ./config/baraction/mem.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/mic.sh" = {
        source = ./config/baraction/mic.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/temp.sh" = {
        source = ./config/baraction/temp.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/vol.sh" = {
        source = ./config/baraction/vol.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/baraction/wifi.sh" = {
        source = ./config/baraction/wifi.sh;
        onChange = reloadCmd;
      };
      "${binaryName}/screenshot.sh" = {
        source = ./config/screenshot.sh;
        executable = true;
      };
      "${binaryName}/spectrwm.conf" = {
        source = ./config/spectrwm.conf;
        onChange = reloadCmd;
      };
    };

  xsession = {
    enable = true;
    windowManager.command = "${pkgs.spectrwm}/bin/spectrwm";
  };
}
