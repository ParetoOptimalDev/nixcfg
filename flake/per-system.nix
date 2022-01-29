{ inputs, rootPath, system }:

let

  config = {
    allowAliases = false;
    allowUnfree = true;
    packageOverrides = import "${rootPath}/pkgs";
  };

  unstable = import inputs.nixpkgs-unstable {
    inherit config system;
  };

  overlays = [
    (final: prev: {
      inherit unstable;
    })

    inputs.kmonad.overlay
  ];

  pkgs = import inputs.nixpkgs {
    inherit config overlays system;
  };

in

{
  inherit pkgs;

  customLib = import (rootPath + "/lib") {
    inherit (inputs.nixpkgs) lib;
    inherit pkgs;
  };
}
