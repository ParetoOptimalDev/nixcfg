{ pkgs, inputs, system, ... }:

{

  home = {
    packages = with pkgs; [ ];
    sessionVariables = {
      EDITOR = "vim";
    };
  };

  programs = {

    ssh.enable = true;

    tmux = {
      enable = true;
      tmuxinator.enable = true;
    };

    zsh = import ./home/zsh.nix;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      stdlib = ''
        direnv reload

        : ''${XDG_CACHE_HOME:=$HOME/.cache}
        declare -A direnv_layout_dirs
        direnv_layout_dir() {
            echo "''${direnv_layout_dirs[$PWD]:=$(
                echo -n "$XDG_CACHE_HOME"/direnv/layouts/
                echo -n "$PWD" | shasum | cut -d ' ' -f 1
            )}"
        }
      '';
    };

    starship.enable = true;

    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
  };
}

