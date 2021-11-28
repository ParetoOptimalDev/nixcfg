{ pkgs, inputs, system, ... }:

{

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
          scrot
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
    sessionVariables = {
      EDITOR = "vim";
    };
  };

  programs = {

    alacritty = import ./home/alacritty.nix;
    direnv = import ./home/direnv.nix;
    git = import ./home/git.nix;
    ssh = import ./home/ssh.nix;
    tmux = import ./home/tmux.nix;
    vim = import ./home/vim.nix { inherit pkgs; };
    zsh = import ./home/zsh.nix;

    bat.enable = true;
    exa.enable = true;
    feh.enable = true;
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
}

