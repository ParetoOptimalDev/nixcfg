{ pkgs, username, ... }:

{
  imports = [
    (import ./common.nix { inherit pkgs username; })

    ./desktop.nix
    ./direnv.nix
    (import ./input.nix { inherit username; })
    ./network.nix
    ./packages.nix
    ./printing.nix
    ./sound.nix
    (import ./user { inherit pkgs username; })
    (import ./virtualbox.nix { inherit username; })
    (import ./vpn.nix { inherit username; })
  ];
}
