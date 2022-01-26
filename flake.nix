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
      # Add support for statix
      #url = "github:maydayv7/pre-commit-hooks.nix/patch-1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";

      flakeLib = import ./flake {
        inherit inputs;
        rootPath = ./.;
      };

      inherit (nixpkgs.lib) listToAttrs;
      inherit (flakeLib) mkNixos;
    in
    {
      homeConfigurations = listToAttrs [ ];

      nixosConfigurations = listToAttrs [
        (mkNixos "x86_64-linux" "n75")
      ];

      #nixosConfigurations = {
      #  altair = mkComputer
      #    ./workstation/altair
      #    [
      #      ./modules/gaming.nix

      #      # home-manager configuration
      #      home-manager.nixosModules.home-manager
      #      {
      #        home-manager.useGlobalPkgs = true;
      #        home-manager.useUserPackages = true;
      #        home-manager.users.${username} = import ./home/home.nix
      #          {
      #            inherit inputs system pkgs;
      #          };
      #      }
      #    ];

      #  n75 = mkComputer
      #    ./workstation/n75
      #    [
      #      (import ./modules/bluecare { inherit pkgs username; root = self; })
      #      (import ./modules/container.nix { inherit pkgs username; })
      #      ./modules/mobile.nix

      #      # home-manager configuration
      #      home-manager.nixosModules.home-manager
      #      {
      #        home-manager.useGlobalPkgs = true;
      #        home-manager.useUserPackages = true;
      #        home-manager.users.${username} = import ./home/work.nix
      #          {
      #            inherit inputs system pkgs;
      #          };
      #      }
      #    ];

      #  nixos-vm = mkComputer
      #    ./workstation/nixos-vm
      #    [
      #      # home-manager configuration
      #      home-manager.nixosModules.home-manager
      #      {
      #        home-manager.useGlobalPkgs = true;
      #        home-manager.useUserPackages = true;
      #        home-manager.users.${username} = import ./home/nixos-vm.nix
      #          {
      #            inherit inputs system pkgs;
      #          };
      #      }
      #    ];
      #};

      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            shellcheck.enable = true;
            #statix.enable = true;
          };
        };
      };

      devShell.${system} =
        let
          config = {
            allowUnfree = true;
            packageOverrides = import ./pkgs;
          };
          pkgs = import nixpkgs { inherit config system; };
        in
        pkgs.mkShell {

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
