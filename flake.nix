{
  description = "NixOS & Home-Manager Configuration";

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

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, kmonad, ... }:
    let
      username = "christian";
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        packageOverrides = import ./pkgs;
      };

      overlay-unstable = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit config system;
        };
      };

      pkgs = import nixpkgs {
        inherit config system;
        overlays = [
          overlay-unstable
          kmonad.overlay
        ];
      };

      mkComputer = configurationNix: extraModules: nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit self system inputs; };
        modules = (
          [
            # System configuration for this host
            (import configurationNix { inherit pkgs; root = self; })

            # Common configuration
            (import ./modules/common { inherit pkgs username; })

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
            ./modules/gaming.nix

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
            (import ./modules/bluecare { inherit pkgs username; root = self; })
            (import ./modules/container.nix { inherit pkgs username; })
            ./modules/mobile.nix

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

      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            shellcheck.enable = true;
          };
        };
      };

      devShell.${system} = pkgs.mkShell {

        name = "nixcfg";

        buildInputs = with pkgs; [
          figlet
          lolcat # banner printing on enter

          home-manager
        ];

        shellHook = ''
          figlet $name | lolcat --freq 0.5
          ${(self.checks.${system}.pre-commit-check).shellHook}
          ${pkgs.pre-commit}/bin/pre-commit install
        '';
      };
    };
}
