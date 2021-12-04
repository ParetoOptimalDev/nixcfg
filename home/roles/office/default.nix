{ pkgs, ... }:

{
  imports = [
    ./cli
  ];

  home.packages = with pkgs; [
    libreoffice
    sent # plaintext presentations
  ];
}
