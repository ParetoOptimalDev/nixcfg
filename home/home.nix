{ pkgs, inputs, system, ... }:

{
  imports = [
    ./default.nix
    ./env/home
    ./roles/gaming.nix
    ./roles/office.nix
  ];

  programs = {
    git = import ./common/git.nix {
      userEmail = "christian@harke.ch";
    };
  };

  xdg.configFile = {
    # TODO: configure by autorandr
    "spectrwm/initscreen.sh" = {
      text = ''
        #!/usr/bin/env bash
        xrandr --output DP-4 --rate 144 --mode 1920x1080 --output HDMI-0 --off
      '';
      executable = true;
    };
  };
}
