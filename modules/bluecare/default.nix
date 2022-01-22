{ root, pkgs, username, ... }:

{
  imports = [
    (import ./devmail { inherit root pkgs; })
    (import ./fileSystems { inherit pkgs username; })
    (import ./openvpn { inherit username; })
    ./printing
  ];
}
