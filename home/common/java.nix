{ pkgs, ... }:

let

  java = pkgs.jdk;
  java8 = pkgs.jdk8;
  java11 = pkgs.jdk11;
  jfx11 = pkgs.openjfx11;

in

{
  home = {
    packages = [
      java
      java8
      java11
      jfx11
    ];

    sessionVariables = {
      JAVA_HOME = "${java}/lib/openjdk";
      JAVA8_HOME = "${java8}/lib/openjdk";
      JAVA11_HOME = "${java11}/lib/openjdk";
      JDK_HOME = "${java}/lib/openjdk";
      JDK8_HOME = "${java8}/lib/openjdk";
      JDK11_HOME = "${java11}/lib/openjdk";

      # IntelliJ IDEA Code with me
      INTELLIJCLIENT_JDK = "${java11}/lib/openjdk";
    };
  };
}
