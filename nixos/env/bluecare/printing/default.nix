{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.printing;

in

{
  options = {
    custom.env.bluecare.printing = {
      enable = mkEnableOption "Git config";
    };
  };

  config = mkIf cfg.enable {
    # hardware.printers =
    # let
    #   credentials = "${acc.domain}\\${acc.username}:${acc.password}";
    #   printserver = "bluecare-s20";
    #   location = "BlueCare";
    #   description = "Kyocera TASKalfa 300ci";
    #   model = "Kyocera/Kyocera_TASKalfa_300ci.ppd";
    # in
    # {
    #   ensurePrinters = [
    #     {
    #       name = "FollowMe";
    #       location = location;
    #       description = description;
    #       deviceUri = "smb://${credentials}@${printserver}/FollowMe";
    #       model = model;
    #     }
    #     {
    #       name = "FollowMe_Color";
    #       location = location;
    #       description = "${description} Color";
    #       deviceUri = "smb://${credentials}@${printserver}/FollowMe%20Color";
    #       model = model;
    #     }
    #   ];
    #   ensureDefaultPrinter = "FollowMe";
    # };

    services = {
      # Not available anymore:
      # https://la.kyoceradocumentsolutions.com/content/dam/kdc/kdag/downloads/technical/executables/drivers/kyoceradocumentsolutions/lad/en/Kyocera_Linux_PPD_Ver_8.1601.tar.gz
      # New: https://www.kyoceradocumentsolutions.us/content/download-center-americas/us/drivers/drivers/Kyocera_Linux_PPD_Ver_8_1601_tar_gz.download.gz
      # Small: https://www.kyoceradocumentsolutions.us/content/download-center-americas/us/drivers/drivers/Kyocera_TASKalfa_300ci_PPD_zip.download.zip
      # EU: https://www.kyoceradocumentsolutions.ch/content/download-center/ch/drivers/all/LinuxCUPS1_4_zip.download.zip
      #    printing.drivers = [ pkgs.cups-kyodialog3 ];
    };
  };
}
