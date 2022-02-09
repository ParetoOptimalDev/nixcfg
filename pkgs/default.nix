pkgs:
let
  callPackage = pkgs.lib.callPackageWith (custom // pkgs);
  custom = pkgs // {
    hinclient = callPackage ./hinclient { };

    # Overriding
    # spectrwm = callPackage ./spectrwm {};
  };
in
custom
