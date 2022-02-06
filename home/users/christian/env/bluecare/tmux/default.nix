{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.tmux;

in

{
  options = {
    custom.users.christian.env.bluecare.tmux = {
      enable = mkEnableOption "Tmux config";
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "tmuxinator/bcon-full.yml".source = ./config/bcon-full.yml;
      "tmuxinator/bcon-int.yml".source = ./config/bcon-int.yml;
      "tmuxinator/bcon-prod.yml".source = ./config/bcon-prod.yml;
      "tmuxinator/bcon-sta.yml".source = ./config/bcon-sta.yml;
      "tmuxinator/bcon.yml".source = ./config/bcon.yml;
      "tmuxinator/cci.yml".source = ./config/cci.yml;
      "tmuxinator/ps.yml".source = ./config/ps.yml;
      "tmuxinator/ssh/jump.aspectra.com".source = ./config/ssh/jump.aspectra.com;
    };
  };
}
