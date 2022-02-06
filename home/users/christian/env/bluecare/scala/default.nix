{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.scala;

in

{
  options = {
    custom.users.christian.env.bluecare.scala = {
      enable = mkEnableOption "Scala config";
    };
  };

  config = mkIf cfg.enable {
    custom.roles.dev.scala = {
      repositories = ''
        [repositories]
        local
        my-ivy-proxy-releases: https://devops-repo.dev.bluecare.ch/artifactory/ivy-releases/, [organization]/[module]/(scala_[scalaVersion]/)(sbt_[sbtVersion]/)[revision]/[type]s/[artifact](-[classifier]).[ext]
        my-maven-proxy-releases: https://devops-repo.dev.bluecare.ch/artifactory/mvn-releases/
        my-snapshots: https://devops-repo.dev.bluecare.ch/artifactory/libs-snapshot/
      '';
    };
  };
}
