{ pkgs, inputs, system, ... }:

{
  imports = [
    ./default.nix
    ./env/home
    ./roles/office.nix
  ];

  programs = {
    git = import ./common/git.nix {
      userEmail = "christian@harke.ch";
    };
  };

  xdg.configFile = {
    "spectrwm/initscreen.sh" = {
      text = ''
        #!/usr/bin/env bash
        # Do nothing
      '';
      executable = true;
    };
  };
}
