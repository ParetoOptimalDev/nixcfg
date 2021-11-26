{ pkgs, config, ... }:

let

  username = import ../../username.nix;

in

{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ username ];
}
