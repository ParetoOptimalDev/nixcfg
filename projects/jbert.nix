{ config, pkgs, ... }:

let

  username = import ../username.nix;

in

{
  imports =
    [
      ../modules/java.nix
    ];

  services.mpd = {
    enable = true;
    dataDir = "/tmp/jbert";
    group = "audio";
  };

  users.users.${username}.extraGroups = [
    "audio"
  ];
}

