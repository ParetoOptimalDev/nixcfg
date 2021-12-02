{ pkgs, inputs, system, ... }:

{
  imports = [
    ./common
    ./env/work
    ./roles/dev.nix
    ./roles/mobile.nix
    ./roles/office.nix
    ./roles/ops.nix
  ];

  home.packages = with pkgs; [
    robo3t
    slack
    teams
    zoom-us
  ];

  programs = {
    git = import ./common/git.nix {
      userEmail = "christian.harke@bluecare.ch";
    };
  };

  xdg.configFile = {
    # TODO: configure by autorandr
    "spectrwm/initscreen.sh" = {
      text = ''
        #!/usr/bin/env bash
        # do nothing
      '';
      executable = true;
    };
  };
}
