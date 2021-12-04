{ pkgs, ... }:

{
  imports = [
    ./icons
    ./terminal
    ./spectrwm
  ];

  home = {
    packages = with pkgs; [
      # Locker
      i3lock-pixeled

      # Misc
      mupdf
      peek
      gifski
      xclip
      xzoom
    ];
  };

  services = {
    redshift = import ./redshift;
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
