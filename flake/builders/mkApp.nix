{ inputs, rootPath, pkgs, customLib, name, args, ... }:

let

  mkPath = args.path or (pkgs: [ ]);

in

inputs.flake-utils.lib.mkApp {
  drv = customLib.mkScript
    name
    args.file
    (mkPath pkgs)
    (args.envs or { });
}
