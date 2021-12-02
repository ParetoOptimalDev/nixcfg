{ pkgs, ... }:

{
  imports = [
    ../common/intellij.nix
    ../common/java.nix
    ../common/js.nix
    ../common/python.nix
    ../common/scala.nix
  ];

  home.packages = [
    pkgs.ascii
  ];
}
