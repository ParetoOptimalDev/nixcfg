{ pkgs, ... }:

with pkgs;

{
  fonts.fontconfig.enable = true;

  home.packages = [
    corefonts
    google-fonts
    ubuntu_font_family
  ];
}
