pkgs:
let
  callPackage = pkgs.lib.callPackageWith (custom // pkgs);
  p = import ../nix/sources.nix { };
  custom = p // {
    hinclient = callPackage ./hinclient { };

    # Overriding
    i3lock-pixeled = callPackage ./i3lock-pixeled { };
    # spectrwm = callPackage ./spectrwm {};
  };
in
custom
