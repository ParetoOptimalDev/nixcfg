{ lib, pkgs, rootPath } @ args:

let
  callPackage = lib.callPackageWith args;

  script = callPackage ./script { };

  homeBasePath = rootPath + "/home";
  hostsBasePath = rootPath + "/hosts";
  nixosBasePath = rootPath + "/nixos";
in

{
  inherit (script) mkScript;

  mkHomePath = p: homeBasePath + p;
  mkHostPath = host: p: hostsBasePath + "/${host}" + p;
  mkNixosPath = p: nixosBasePath + p;
}
