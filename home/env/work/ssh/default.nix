{
  programs.ssh.extraConfig = ''
    # ASPECTRA
    Host aspectra-deployment
      User deployment
      HostName 172.24.40.15
      ProxyJump jenkins.dev.bluecare.ch
      IdentityFile ~/.ssh/id_rsa_aspectra
      PubkeyAcceptedAlgorithms +ssh-rsa
      HostkeyAlgorithms +ssh-rsa
    Host jump.aspectra.com
      User blcchha

    # DEVOPS
    Host bcon-*.dev.bluecare.ch
      User beryllium
    Host *.dev.bluecare.ch
      User ansibleremote
  '';
}
