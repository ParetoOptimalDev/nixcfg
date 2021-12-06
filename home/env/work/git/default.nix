{
  programs = {
    git = {
      userEmail = "christian.harke@bluecare.ch";
    };
    ssh.matchBlocks = {
      "code.bluecare.ch" = {
        user = "git";
        extraOptions = {
          PubkeyAcceptedAlgorithms = "+ssh-rsa";
          HostkeyAlgorithms = "+ssh-rsa";
        };
      };
    };
  };
}
