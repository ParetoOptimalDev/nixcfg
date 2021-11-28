{ pkgs, inputs, system, ... }:

{
  imports = [
    ./common
  ];

  programs = {
    git = import ./common/git.nix {
      userEmail = "christian@harke.ch";
    };
  };
}
