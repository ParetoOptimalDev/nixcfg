{
  custom = {
    base.non-nixos.enable = true;

    users = {
      dev = {
        enable = true;
      };
      christian.env.bluecare.enable = true;
    };

    roles = {
      desktop.enable = true;
      dev.enable = true;
      graphics.enable = true;
      multimedia.enable = true;
      office.enable = true;
      web.enable = true;
    };
  };
}
