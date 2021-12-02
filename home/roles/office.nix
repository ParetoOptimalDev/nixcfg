{ pkgs, ... }:

{
  imports = [
    ../common/cli-office
  ];

  home.packages = with pkgs; [
    libreoffice
    sent # plaintext presentations
  ];
}
