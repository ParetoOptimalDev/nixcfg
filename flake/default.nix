{ inputs, rootPath }:

let

  homeModulesBuilder = { inputs, rootPath, customLib, ... }:
    [
      (rootPath + "/home")

      {
        lib.custom = customLib;
      }
    ];

  wrapper = builder: system: name: args:
    let
      flakeArgs = { inherit inputs rootPath system; };
      perSystem = import ./per-system.nix flakeArgs;

      homeModules = homeModulesBuilder (flakeArgs // perSystem);

      builderArgs = flakeArgs // perSystem // { inherit args homeModules name; };
    in
    inputs.nixpkgs.lib.nameValuePair name (import builder builderArgs);

  simpleWrapper = builder: system: name: wrapper builder system name { };

in

{
  mkNixos = simpleWrapper ./builders/mkNixos.nix;

  eachSystem =
    inputs.flake-utils.lib.eachSystem
      [ "aarch64-linux" "x86_64-linux" ];
}
