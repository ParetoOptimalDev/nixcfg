{ pkgs, ... }:

{
  home.packages = [
    pkgs.direnv
  ];

  programs.direnv.enable = true;
  services.lorri.enable = true;
}
