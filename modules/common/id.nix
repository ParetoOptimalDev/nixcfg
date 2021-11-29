{ config, pkgs, ... }:

{
  security.pam.enableSSHAgentAuth = true;
}
