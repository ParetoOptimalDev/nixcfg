pkgs:
let
  callPackage = pkgs.lib.callPackageWith (custom // pkgs);
  custom = pkgs // {
    # Overriding
    # spectrwm = callPackage ./spectrwm {};
  };
in
custom
