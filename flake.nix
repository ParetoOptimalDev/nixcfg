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

      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            shellcheck.enable = true;
          };
        };
      };

      devShell.${system} =
        let
          pkgs = import nixpkgs { inherit system; };
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
