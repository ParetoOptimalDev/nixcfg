{ pkgs, ... }:

{
  imports = [
    ./bin
    ./cli-office
    ./davmail.nix
    ./icons.nix
    ./ranger
    ./scala
    ./tmux
    ./xorg
  ];

  programs.git = import ./git;
  services.grobi = import ./grobi { inherit pkgs; };
}
