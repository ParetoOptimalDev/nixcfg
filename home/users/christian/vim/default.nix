{ config, lib, pkgs, machNix, ... }:

with lib;

let

  cfg = config.custom.users.christian.vim;

  vimwiki-cli = machNix.buildPythonPackage {
    src = builtins.fetchGit {
      url = "https://github.com/sstallion/vimwiki-cli";
      ref = "refs/tags/v1.0.0";
      rev = "6e7689e052d1462d950e6af19964c97827216e64";
    };
  };

in

{
  options = {
    custom.users.christian.vim = {
      enable = mkEnableOption "VIM config";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [
        pkgs.custom.neovim
        vimwiki-cli
      ];
      sessionVariables =
        {
          EDITOR = "vim";
        };
    };
  };
}
