let

  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [ moz_overlay ];
  };

in

with pkgs;

mkShell {

  name = "nixos-config";

  buildInputs = [
    figlet
    lolcat # banner printing on enter

    git
    niv
    nixpkgs-fmt
    pre-commit
    latest.rustChannels.nightly.rust
    latest.rustChannels.nightly.rust-src
    rustup
  ];

  shellHook = ''
    figlet $name | lolcat --freq 0.5

    pre-commit install-hooks
  '';
}

