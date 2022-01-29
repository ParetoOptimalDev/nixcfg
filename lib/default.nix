{ lib, pkgs, rootPath } @ args:

let
  callPackage = lib.callPackageWith args;

  fileList = callPackage ./file-list.nix { };
  homeBasePath = rootPath + "/home";
  nixosBasePath = rootPath + "/nixos";
in

{
  inherit (fileList) getFileList getRecursiveNixFileList getRecursiveDefaultNixFileList;

  mkHomePath = p: homeBasePath + p;
  mkNixosPath = p: nixosBasePath + p;
}
