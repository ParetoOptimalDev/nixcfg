{ username, ... }:

{
  services = {
    openvpn.servers.bluecare = {
      autoStart = false;
      config = "config /home/${username}/.accounts/bluecare/ovpn/chr@vpfwblue.bluecare.ch.ovpn";
      updateResolvConf = true;
    };
  };
}
