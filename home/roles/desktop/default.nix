{ pkgs, ... }:

{
  imports = [
    ./cursors
    ./gtk
    ./terminal
    ./xmonad
  ];

  home = {
    packages = with pkgs; [
      # Locker
      i3lock-pixeled

      # Misc
      gnome.pomodoro
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
