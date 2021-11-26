{ pkgs, config, ... }:

let

  username = import ../../../username.nix;

in

{
  users.users.${username} = {
    name = username;
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "scanner"
    ];
    initialPassword = "changeme";
    openssh.authorizedKeys.keyFiles = [ ./id_rsa.pub ];
  };
}
