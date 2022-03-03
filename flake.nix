{
  description = "NixOS & Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-commons = {
      url = "github:christianharke/flake-commons";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };
    flake-utils.url = "github:numtide/flake-utils";

    i3lock-pixeled = {
      url = "gitlab:christianharke/i3lock-pixeled";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    mach-nix = {
      url = "github:DavHau/mach-nix/3.3.0";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
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
    // eachSystem ({ mkGeneric, mkApp, mkCheck, getDevShell, mkDevShell, ... }:
      let
        mkShellCheck = pkgs: ''
          shopt -s globstar
          echo 'Running shellcheck...'
          ${pkgs.shellcheck}/bin/shellcheck --check-sourced --enable all --external-sources --shell bash ${./.}/**/*.sh
        '';
      in
      {
        apps = listToAttrs [
          (mkApp "setup" {
            file = "setup.sh";
            envs = {
              _doNotClearPath = true;
              flakePath = "/home/\$(logname)/.nix-config";
            };
            path = pkgs: with pkgs; [
              git
              hostname
              jq
            ];
          })

          (mkApp "nixos-install" {
            file = "nixos-install.sh";
            envs = {
              _doNotClearPath = true;
            };
            path = pkgs: with pkgs; [
              git
              hostname
              util-linux
              parted
              cryptsetup
              lvm2
            ];
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
            script = mkShellCheck;
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
            customShellHook = mkShellCheck;
          })
        ];
      });
}
