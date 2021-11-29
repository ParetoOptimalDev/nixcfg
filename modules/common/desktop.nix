{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  environment.systemPackages = with pkgs; [
    acpi
    dmenu
    i3lock-pixeled
    lm_sensors
    lxappearance
    rofi # Necessary for fontawesome/unicode symbol finder
  ];

  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
  };

  services = {
    autorandr.enable = true;

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      windowManager.spectrwm.enable = true;
      displayManager.sessionCommands = ''
        feh --no-fehbg --bg-fill --randomize /home/christian/Pictures/wallpapers
      '';

      serverFlagsSection = ''
        Option "BlankTime" "15"
        Option "StandbyTime" "15"
        Option "SuspendTime" "15"
        Option "OffTime" "15"
      '';
    };
  };
}
