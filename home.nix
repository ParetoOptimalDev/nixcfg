{ pkgs, inputs, system, ... }:

{

  home = {
    packages = with pkgs; [ ];
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
    zsh = import ./home/zsh.nix;

    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
    starship.enable = true;
  };
}

