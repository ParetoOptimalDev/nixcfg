{ pkgs, inputs, system, ... }:

{
  imports = [
    ./common
    ./common/intellij.nix
    ./common/java.nix
    ./work
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
