{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.dev.java;

  java = pkgs.jdk;
  jfx = pkgs.openjfx11;

in

{
  options = {
    custom.roles.dev.java = {
      enable = mkEnableOption "Java";
    };
  };

  config = mkIf cfg.enable {
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
  };
}
