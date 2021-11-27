{ pkgs, config, ... }:

let

  username = import ../../../username.nix;

in

{
  programs = {
    vim.defaultEditor = true;
    zsh.enable = true;
  };

  users.users.${username} = {
    shell = pkgs.zsh;
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
