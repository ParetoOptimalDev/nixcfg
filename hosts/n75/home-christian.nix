{ pkgs, ... }:

{
  imports = [
    ./home/grobi
    ./home/kmonad
    ./home/xbindkeys
  ];

  custom = {
    users.christian = {
      enable = true;
      env.bluecare.enable = true;
    };

    roles = {
      desktop = {
        enable = true;
        mobile.enable = true;
      };
      dev.enable = true;
      graphics.enable = true;
      multimedia.enable = true;
      office.enable = true;
      web.enable = true;
    };
  };
}
