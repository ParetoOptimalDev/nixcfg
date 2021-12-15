{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, kmonad, ... }:
    let
      username = import ./username.nix;
      system = "x86_64-linux";

      overlay-unstable = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
            packageOverrides = import ./pkgs;
          };
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          packageOverrides = import ./pkgs;
        };
        overlays = [
          overlay-unstable
          kmonad.overlay
        ];
      };

      mkComputer = configurationNix: extraModules: nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit system inputs; };
        modules = (
          [
            # System configuration for this host
            configurationNix

            # Common configuration
            ./modules/common

            kmonad.nixosModule
          ] ++ extraModules
        );
      };

    in
    {
      nixosConfigurations = {
        altair = mkComputer
          ./workstation/altair
          [
            # home-manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home/home.nix
                {
                  inherit inputs system pkgs;
                };
            }
          ];

        n75 = mkComputer
          ./workstation/n75
          [
            # home-manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home/work.nix
                {
                  inherit inputs system pkgs;
                };
            }
          ];

        nixos-vm = mkComputer
          ./workstation/nixos-vm
          [
            # home-manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home/nixos-vm.nix
                {
                  inherit inputs system pkgs;
                };
            }
          ];
      };

      # Non-NixOS Systems
      #homeConfigurations =
      #let
      #homeDirectory = "/home/${username}";
      #baseConfiguration = {
      #programs.home-manager.enable = true;
      #home = {
      #username = username;
      #homeDirectory = homeDirectory;
      #};
      #};
      #mkHomeConfig = cfg: home-manager.lib.homeManagerConfiguration {
      #inherit username system homeDirectory;
      #configuration = baseConfiguration // cfg;
      #};
      #in
      #{
      #"tbd" = mkHomeConfig {
      #programs.git = import ./home/git.nix;
      #};
      #};

      devShell."${system}" = import ./shell.nix { inherit pkgs; };
    };
}
