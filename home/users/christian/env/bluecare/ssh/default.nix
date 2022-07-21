{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.ssh;

in

{
  options = {
    custom.users.christian.env.bluecare.ssh = {
      enable = mkEnableOption "SSH config";
    };
  };

  config = mkIf cfg.enable {
    programs.ssh.extraConfig = ''
      # ASPECTRA
      Host aspectra-deployment
        User deployment
        HostName 172.24.35.28
        ProxyJump jenkins.dev.bluecare.ch
        IdentityFile ~/.ssh/id_rsa_aspectra
        PubkeyAcceptedAlgorithms +ssh-rsa
        HostkeyAlgorithms +ssh-rsa
      Host jump.aspectra.com
        User blcchha

      # DEVOPS
      Host bcon-*.dev.bluecare.ch
        User beryllium
        PubkeyAcceptedAlgorithms +ssh-rsa
        HostkeyAlgorithms +ssh-rsa
      Host bcr79-ls85.bluecare.local
        User beryllium
      Host mcsi-staging.dev.bluecare.ch
        User devuser
        PubkeyAcceptedAlgorithms +ssh-rsa
        HostkeyAlgorithms +ssh-rsa
      Host *.dev.bluecare.ch
        User ansibleremote
        PubkeyAcceptedAlgorithms +ssh-rsa
        HostkeyAlgorithms +ssh-rsa
    '';
  };
}
