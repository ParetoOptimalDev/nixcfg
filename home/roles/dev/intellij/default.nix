{ pkgs, ... }:

with pkgs;

{
  home = {
    packages = [
      openjfx11
      jetbrains.idea-ultimate
    ];

    sessionVariables = {
      # IntelliJ IDEA Code with me
      INTELLIJCLIENT_JDK = "${jdk11}/lib/openjdk";
    };
  };
}
