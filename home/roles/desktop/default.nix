{ pkgs, ... }:

{
  imports = [
    ./icons
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

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
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
