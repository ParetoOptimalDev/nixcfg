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
  ];

  overlays = [
    (final: prev: {
      inherit unstable;

      custom = prev.lib.composeManyExtensions customOverlays final prev;
    })

    inputs.kmonad.overlay
  ];

  pkgs = import inputs.nixpkgs {
    inherit config overlays system;
  };

in

{
  inherit pkgs;

  customLib = (import (rootPath + "/lib")
    {
      inherit (inputs.nixpkgs) lib;
      inherit pkgs rootPath;
    }) // inputs.flake-commons.lib.${system};
}
