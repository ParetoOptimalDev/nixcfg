# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let

  username = import ../username.nix;

in

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include role configuration
    ../modules/container.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    # Define on which hard drive you want to install Grub.
    device = "/dev/sda";
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
    #   consoleFont = "Lat2-Terminus16";
    #   consoleKeyMap = "en";
    defaultLocale = "de_CH.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable VMware Tools
  services.vmwareGuest = {
    enable = true;
    headless = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    uid = 1000;
    initialPassword = "changeme";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keyFiles = [ ../modules/common/user/id_rsa.pub ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

  # Keep the system up-to-date
  system.autoUpgrade.enable = true;
}
