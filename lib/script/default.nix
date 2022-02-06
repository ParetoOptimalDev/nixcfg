{ lib, pkgs }:

with lib;

let

  builder =
    { destPath
    , envs
    , file
    , name
    , path ? [ ]
    }:
    pkgs.runCommand
      name
      (envs // {
        inherit (pkgs) runtimeShell;
        bashLib = ./lib.sh;
        path =
          makeBinPath (path ++ [ pkgs.coreutils ])
            + optionalString (envs ? _doNotClearPath && envs._doNotClearPath) ":\${PATH}";
      })
      ''
        file=${destPath}
        mkdir --parents "$(dirname "$file")"

        cat ${./preamble.sh} "${file}" > "$file"
        substituteAllInPlace "$file"

        chmod +x "$file"
      '';

in

{
  mkScript = name: file: path: envs:
    builder {
      inherit name file path envs;
      destPath = "${placeholder "out"}/bin/${name}";
    };
}
