{
  description = "NixOS & Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      flakeLib = import ./flake {
        inherit inputs;
        rootPath = ./.;
      };

      inherit (nixpkgs.lib) listToAttrs;
      inherit (flakeLib) mkHome mkNixos eachSystem;
    in
    {
      homeConfigurations = listToAttrs [
        (mkHome "x86_64-linux" "dev@dev-vm")
      ];

      nixosConfigurations = listToAttrs [
        (mkNixos "x86_64-linux" "altair")
        (mkNixos "x86_64-linux" "n75")
        (mkNixos "x86_64-linux" "nixos-vm")
      ];
    }
    // eachSystem ({ mkGeneric, mkApp, mkCheck, getDevShell, mkDevShell, ... }: {
      apps = listToAttrs [
        (mkApp "setup" {
          file = "setup.sh";
          envs = {
            _doNotClearPath = true;
            flakePath = "/home/\$(logname)/.nix-config";
          };
          path = pkgs: with pkgs; [ git gnugrep hostname jq nix_2_4 ];
        })
      ];

      checks = listToAttrs [
        (mkGeneric "pre-commit-check" (system: inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            shellcheck.enable = true;
          };
        }))

        (mkCheck "shellcheck" {
          script = pkgs: ''
            shopt -s globstar
            ${pkgs.shellcheck}/bin/shellcheck -x ${./.}/**/*.sh
          '';
        })

        (mkCheck "nixpkgs-fmt" {
          script = pkgs: ''
            shopt -s globstar
            ${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt --check ${./.}/**/*.nix
          '';
        })
      ];

      devShell = getDevShell "nixcfg";

      devShells = listToAttrs [
        (mkDevShell "nixcfg" {
          checksShellHook = system: (self.checks.${system}.pre-commit-check).shellHook;
          packages = pkgs: with pkgs; [ nixpkgs-fmt shellcheck ];
        })
      ];
    });
}
