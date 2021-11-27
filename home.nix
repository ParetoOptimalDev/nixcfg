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

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      dotDir = ".config/zsh";
      history =
        let
          historySize = 1000000;
        in
        {
          expireDuplicatesFirst = true;
          extended = true;
          ignoreDups = true;
          ignoreSpace = true;
          save = historySize;
          share = true;
          size = historySize;
        };
      shellAliases = {
        # List the last ten directories we've been to this session, no duplicates
        d = "dirs -v | head -10";
        cat = "bat";
        grep = "rg";
        l = "exa -hl --git --icons";
        la = "exa -ahl --git --icons";
        ll = "l";
        ls = "ls -sh --color='auto'";
        lsa = "ls -a";
        tree = "l --tree";

        # File manager
        rr = "ranger";

        # Tmuxinator
        mux = "tmuxinator";

        # Calendar shortcuts
        cal = "khal -v ERROR calendar 2>/dev/null";
        yesterday = "cal yesterday 24h --format '{start-end-time-style} {title}'";
        today = "cal today 24h --format '{start-end-time-style} {title}'";
        tomorrow = "cal tomorrow 24h --format '{start-end-time-style} {title}'";

        # Open Fontawesome icon selector
        fa = "fontawesome-menu -f icon-list.txt";

        # Java REPL
        jshell = "nix-shell -p openjdk --command jshell";
        visualvm = "visualvm --cp:a ~/jmx/jmxremote_optional.jar";

        # Git CLI UI
        lg = "lazygit";

        # PDF viewer
        mupdf = "mupdf-x11";

        # Password manager
        pass = "source pass";
      };
      shellGlobalAliases = {
        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
        "......" = "../../../../..";
        "......." = "../../../../../..";
        "........" = "../../../../../../..";
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

