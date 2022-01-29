{ lib, pkgs, rootPath } @ args:

let
  callPackage = lib.callPackageWith args;

  fileList = callPackage ./file-list.nix { };
  homeBasePath = rootPath + "/home";
  hostsBasePath = rootPath + "/hosts";
  nixosBasePath = rootPath + "/nixos";
in

{
  inherit (fileList) getFileList getRecursiveNixFileList getRecursiveDefaultNixFileList;

  mkHomePath = p: homeBasePath + p;
  mkHostPath = host: p: hostsBasePath + "/${host}" + p;
  mkNixosPath = p: nixosBasePath + p;
}
