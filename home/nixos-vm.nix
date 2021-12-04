{ pkgs, inputs, system, ... }:

{
  imports = [
    ./default.nix
    ./env/home
    ./roles/office.nix
  ];

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
