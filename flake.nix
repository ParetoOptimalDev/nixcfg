{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs }:
    let
      username = import ./username.nix;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
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

            # home-manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home.nix
                {
                  inherit inputs system pkgs;
                };
            }
          ] ++ extraModules
        );
      };
    in
    {
      nixosConfigurations = {
        altair = mkComputer
          ./workstation/altair
          [ ];
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
    };
}
