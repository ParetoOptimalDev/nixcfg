{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.hinclient;

in

{
  options = {
    custom.env.bluecare.hinclient = {
      enable = mkEnableOption "HIN client config";
    };
  };

  config =
    # let
    #   acc = config.accounts."bluecare/hin-id";
    # in
    mkIf cfg.enable {
      #   services.hinclient = {
      #     enable = false;
      #     identities = acc.username;
      #     passphrase = acc.password;
      #     keystore = /home + "/${username}/" + .accounts/bluecare/hin + "/${acc.username}.hin";
      #     httpProxyPort = 5016;
      #     clientapiPort = 5017;
      #     smtpProxyPort = 5018;
      #     pop3ProxyPort = 5019;
      #     imapProxyPort = 5020;
      #   };
    };
}
