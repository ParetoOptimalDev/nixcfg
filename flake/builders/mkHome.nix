{ inputs, rootPath, machNix, system, pkgs, homeModules, name, ... }:

let

  # splits "username@hostname"
  splittedName = inputs.nixpkgs.lib.splitString "@" name;

  username = builtins.elemAt splittedName 0;
  hostname = builtins.elemAt splittedName 1;

in

inputs.home-manager.lib.homeManagerConfiguration {
  inherit username pkgs system;

  configuration = rootPath + "/hosts/${hostname}/home-${username}.nix";
  homeDirectory = "/home/${username}";
  stateVersion = "22.05";

  extraModules = homeModules;
  extraSpecialArgs = {
    inherit rootPath machNix;
  };
}
