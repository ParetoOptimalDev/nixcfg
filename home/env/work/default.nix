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

  services.grobi = import ./grobi { inherit pkgs; };
}
