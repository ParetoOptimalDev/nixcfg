{ pkgs, inputs, system, ... }:

{
  imports = [
    ./env/home
    ./modules
    ./roles/common
    ./roles/desktop
    ./roles/office
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
