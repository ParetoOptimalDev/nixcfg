{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ./alacritty.nix
    ./bin
    ./desktop.nix
    ./fonts.nix
    ./kmonad
    ./ranger
    ./tmux.nix
    ./vim
  ];

  home = {
    username = "christian";
    homeDirectory = "/home/${config.home.username}";

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
          udiskie
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
      in
      common ++
      x ++
      image ++
      multimedia ++
      web;

    shellAliases = {
      # Navigating
      d = "dirs -v | head -10";
      l = "exa -hl --git --icons";
      la = "exa -ahl --git --icons";
      ll = "l";
      ls = "ls -sh --color='auto'";
      lsa = "ls -a";
      tree = "l --tree";

      # File reading
      cat = "bat";
      grep = "rg";

      # File manager
      rr = "ranger";

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

    sessionPath = [
      "$HOME/bin"
    ];

    enableNixpkgsReleaseCheck = true;
    stateVersion = import ../../version.nix;
  };

  programs = {

    direnv = import ./direnv.nix;
    git = import ./git;
    ssh = import ./ssh.nix;
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

  services = {
    nextcloud-client = import ./nextcloud-client.nix;

    # Hardware
    udiskie.enable = true;
  };

  xsession = {
    initExtra = ''
      feh --no-fehbg --bg-fill --randomize ~/Pictures/wallpapers
    '';
  };
}
