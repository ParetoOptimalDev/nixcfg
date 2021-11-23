let

  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };

in

pkgs.mkShell {

  name = "nixos-config";

  buildInputs = with pkgs; [
    figlet
    lolcat # banner printing on enter

    nixpkgs-fmt
  ];

  shellHook = ''
    figlet $name | lolcat --freq 0.5

    echo "Running nix file autoformat..."
    nixpkgs-fmt **/*.nix
  '';
}

