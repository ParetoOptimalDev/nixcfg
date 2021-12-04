{ pkgs, inputs, system, ... }:

{
  imports = [
    ./default.nix
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

  xdg.configFile = {
    "spectrwm/initscreen.sh" = {
      text = ''
        #!/usr/bin/env bash
        # do nothing
      '';
      executable = true;
    };
  };
}
