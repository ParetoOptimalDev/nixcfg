{ config, pkgs, ... }:

{
  containers.devmail =
    {
      config = { pkgs, ... }:
        {
          imports = [ (config.lib.custom.mkNixosPath "/dev/devmail.nix") ];
          services.devmail = {
            enable = true;
            primaryHostname = "devmail";
            localDomains = [ "hin.ch" "test.com" ];
          };
        };
      privateNetwork = true;
      hostAddress = "10.231.2.1";
      localAddress = "10.231.2.2";
      autoStart = false;
    };
  networking.extraHosts = ''
    10.231.2.2 devmail
  '';
}
