{ config, ... }:

{
  services.davmail = {
    enable = true;
    url = "https://mail.bluecare.ch/owa";
    config = {
      davmail.server = true;
      davmail.mode = "EWS";
      davmail.caldavPort = 1080;
      davmail.imapPort = 1143;
      davmail.smtpPort = 1025;
      davmail.disableUpdateCheck = true;
      davmail.logFilePath = "${config.xdg.dataHome}/davmail/davmail.log";
      davmail.logFileSize = "1MB";
      log4j.logger.davmail = "WARN";
      log4j.logger.httpclient.wire = "WARN";
      log4j.logger.org.apache.commons.httpclient = "WARN";
      log4j.rootLogger = "WARN";
    };
  };
}
