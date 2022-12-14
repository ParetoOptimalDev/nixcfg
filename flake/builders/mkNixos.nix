{ inputs, rootPath, machNix, system, pkgs, customLib, homeModules, name, ... }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit homeModules rootPath machNix;
  };

  modules = [
    (rootPath + "/hosts/${name}")

    inputs.agenix.nixosModules.age
    inputs.home-manager.nixosModules.home-manager
    inputs.kmonad.nixosModules.default

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

