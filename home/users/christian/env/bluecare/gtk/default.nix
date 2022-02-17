{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.gtk;

in

{
  options = {
    custom.users.christian.env.bluecare.gtk = {
      enable = mkEnableOption "GTK";
    };
  };

  config = mkIf cfg.enable {
    gtk.gtk3.bookmarks = [
      "file:///home/christian/bluecare/larnags/larnags/testing/selenium/src/test/resources/documents BCON UI Test docs"
    ];
  };
}
