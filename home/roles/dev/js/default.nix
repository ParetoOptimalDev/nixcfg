{ pkgs, ... }:

{
  home.packages = [
    pkgs.spidermonkey_91 # REPL
  ];
}
