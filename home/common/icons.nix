{ pkgs, ... }:

with pkgs;

{
  home.packages = [
    gnome3.dconf
  ];

  gtk.enable = true;

  xsession = {
    enable = true;
    pointerCursor = {
      package = bibata-extra-cursors;
      name = "Bibata_Dark_Red";
      size = 0;
    };
  };
}
