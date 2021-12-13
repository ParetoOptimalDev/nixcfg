{ pkgs, inputs, system, ... }:

{
  home.packages = [
    pkgs.sbt
  ];

  home.file.".sbt/repositories".source = ./config/repositories;
}
