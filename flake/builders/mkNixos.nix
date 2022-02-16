{ inputs, rootPath, system, pkgs, customLib, homeModules, name, ... }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit homeModules rootPath;
  };

  modules = [
    (rootPath + "/hosts/${name}")

    inputs.home-manager.nixosModules.home-manager
    inputs.kmonad.nixosModule

    {
      custom.base.hostname = name;

      lib.custom = customLib;

      nixpkgs = {
        inherit pkgs;
      };

      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        registry = {
          nixpkgs.flake = inputs.nixpkgs;
          nix-config.flake = inputs.self;
        };
      };
    }
  ]
  ++ customLib.getRecursiveDefaultNixFileList (rootPath + "/nixos");
}

