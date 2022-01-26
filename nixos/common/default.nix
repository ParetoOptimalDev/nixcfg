{ pkgs, ... }:

{
  imports = [
    #./network.nix
    #./printing.nix
    #./sound.nix
  ];
}
