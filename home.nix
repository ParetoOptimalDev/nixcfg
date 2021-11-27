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

    zsh = {
      enable = true;
      shellAliases = {
        d = "dirs -v | head -10";
        cat = "bat";
        grep = "rg";
        l = "exa -hl --git --icons";
        la = "exa -ahl --git --icons";
        ll = "l";
        ls = "ls -sh --color='auto'";
        lsa = "ls -a";
        tree = "l --tree";
      };
    };

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

