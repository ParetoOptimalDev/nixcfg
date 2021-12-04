{
  home.shellAliases = {
    mux = "tmuxinator";
  };

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
  };
}
