{
  imports = [
    ./cli-office
    ./icons.nix
    ./ranger
    ./xorg
  ];

  programs.git = import ./git;
}
