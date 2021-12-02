{ pkgs, inputs, system, ... }:

{
  home.packages = [
    pkgs.sbt
  ];

  xdg.configFile."sbt/repositories".source = ./config/repositories;
}
