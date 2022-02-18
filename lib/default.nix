{ lib, pkgs, rootPath } @ args:

let
  callPackage = lib.callPackageWith args;

  attrs = callPackage ./attrs.nix { };
  fileList = callPackage ./file-list.nix { };
  script = callPackage ./script { };

  homeBasePath = rootPath + "/home";
  hostsBasePath = rootPath + "/hosts";
  nixosBasePath = rootPath + "/nixos";
in

{
  inherit (attrs) attrsToList genAttrs';
  inherit (fileList) getFileList getRecursiveNixFileList getRecursiveDefaultNixFileList;
  inherit (script) mkScript;

  mkHomePath = p: homeBasePath + p;
  mkHostPath = host: p: hostsBasePath + "/${host}" + p;
  mkNixosPath = p: nixosBasePath + p;
}
