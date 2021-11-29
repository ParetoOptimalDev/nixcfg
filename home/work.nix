{ pkgs, inputs, system, ... }:

{
  imports = [
    ./common
    ./common/intellij.nix
    ./common/java.nix
  ];

  programs = {
    git = import ./common/git.nix {
      userEmail = "christian.harke@bluecare.ch";
    };
  };
}
