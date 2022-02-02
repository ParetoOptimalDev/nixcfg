{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.davmail;

in

{
  options = {
    custom.env.bluecare.davmail = {
      enable = mkEnableOption "Bluecare DavMail";
    };
  };

  config = mkIf cfg.enable {
    custom.programs.davmail = {
      enable = true;
      url = "https://mail.bluecare.ch/owa";
      config = {
        davmail.mode = "EWS";
        davmail.caldavPort = 1080;
        davmail.imapPort = 1143;
        davmail.smtpPort = 1025;
      };
    };
  };
}
