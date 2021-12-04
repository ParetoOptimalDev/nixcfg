{ pkgs, ... }:

{
  imports = [
    ./intellij
    ./java
    ./js
    ./plantuml
    ./python
    ./scala
  ];

  home.packages = [
    pkgs.ascii
  ];
}

