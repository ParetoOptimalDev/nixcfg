{ pkgs, ... }:

{
  imports = [
    ./icons.nix
    ./spectrwm
  ];

  home = {
    packages = with pkgs; [
      # Locker
      i3lock-pixeled
    ];
  };

  services = {
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
  };
}
