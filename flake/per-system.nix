{ inputs, rootPath, system }:

let

  config = {
    allowAliases = false;
    allowUnfree = true;
  };

  unstable = import inputs.nixpkgs-unstable {
    inherit config system;
  };

  customOverlays = [
    inputs.i3lock-pixeled.overlay
    (final: prev: {
      neovim = inputs.neovim.defaultPackage."${system}";
    })
  ];

  overlays = [
    (final: prev: {
      inherit unstable;
      inherit (inputs.agenix-cli.packages."${system}") agenix-cli;

      custom = prev.lib.composeManyExtensions customOverlays final prev;
    })
  ];

  pkgs = import inputs.nixpkgs {
    inherit config overlays system;
  };

  customLib = inputs.flake-commons.lib."${system}" {
    inherit (inputs.nixpkgs) lib;
    inherit pkgs rootPath;
  };

  machNix = import inputs.mach-nix {
    inherit pkgs;
  };

in

{
  inherit pkgs customLib machNix;
}
