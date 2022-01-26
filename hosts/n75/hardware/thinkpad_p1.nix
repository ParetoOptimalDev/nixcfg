{ config, lib, pkgs, ... }:

{

  environment = {
    variables = {
      WINIT_X11_SCALE_FACTOR = "1";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking.wireless = {
    interfaces = [ "wlp82s0" ];
  };

  nix.maxJobs = lib.mkOverride 20 6;

  services = {
    xserver = {
      dpi = 96;
      videoDrivers = [
        "nvidia"
      ];
    };
  };
}
