{ pkgs, ... }:

let

  java = pkgs.jdk;
  jfx = pkgs.openjfx11;

in

{
  home = {
    packages = [
      java
      jfx
    ];

    sessionVariables = {
      JAVA_HOME = "${java}/lib/openjdk";
      JDK_HOME = "${java}/lib/openjdk";

      # IntelliJ IDEA Code with me
      INTELLIJCLIENT_JDK = "${java}/lib/openjdk";
    };
  };
}
