{ pkgs, inputs, system, ... }:

{
  imports = [ ./spectrwm.nix ];

  home = {
    packages =
      let
        common = with pkgs; [
          # Terminal fun
          asciiquarium
          bb
          cowsay
          cmatrix
          figlet
          fortune
          lolcat
          toilet

          # GNU util replacements
          ripgrep

          _1password
          _1password-gui
          bind
          convmv
          eva
          fd # ultra-fast find
          file
          git
          glow
          gnupg
          gron
          htop
          killall
          lazygit
          neofetch
          parted
          exfat
          ranger
          samba
          stow
          trash-cli
          unzip
        ];
        x = with pkgs; [
          mupdf
          peek
          gifski
          xclip
          xzoom
        ];
        image = with pkgs; [
          gimp
          plantuml
          graphviz
          sxiv
        ];
        multimedia = with pkgs; [
          id3lib
          spotifywm
        ];
        web = with pkgs; [
          wget

          thunderbird

          # Messengers
          signal-desktop
          tdesktop # Telegram
        ];
        dev = with pkgs; [
          ascii
          jetbrains.idea-ultimate
          lnav

          # REPLs
          ammonite # Scala
          python3
          spidermonkey # JS
        ];
        office = with pkgs; [
          libreoffice
          sent # plaintext presentations
        ];
      in
      common ++
      x ++
      image ++
      multimedia ++
      web ++
      dev ++
      office;
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
    sessionVariables = {
      EDITOR = "vim";
    };
  };

  programs = {

    alacritty = import ./alacritty.nix;
    direnv = import ./direnv.nix;
    ssh = import ./ssh.nix;
    tmux = import ./tmux.nix;
    vim = import ./vim.nix { inherit pkgs; };
    zsh = import ./zsh.nix;

    bat.enable = true;
    exa.enable = true;
    fzf.enable = true;
    jq.enable = true;
    starship.enable = true;

    # Browsers
    chromium.enable = true;
    firefox.enable = true;
    qutebrowser.enable = true;

    # Multimedia
    mpv.enable = true;
  };

  xsession = {
    profileExtra = ''
      feh --no-fehbg --bg-fill --randomize ~/Pictures/wallpapers
    '';
  };
}
