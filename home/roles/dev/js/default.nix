{ pkgs, ... }:

{
  home.packages = [
    pkgs.spidermonkey # REPL
  ];
}
