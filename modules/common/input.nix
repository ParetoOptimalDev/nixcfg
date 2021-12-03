let

  username = import ../../username.nix;

in

{
  services.xserver = {
    layout = "ch";

    # Touchpad settings
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
        sendEventsMode = "disabled-on-external-mouse";
      };
    };
  };

  console.useXkbConfig = true;

  users.users.${username}.extraGroups = [ "input" ];
}
