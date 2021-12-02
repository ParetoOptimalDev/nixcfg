{ config, lib, pkgs, utils, ... }:

with lib;
with pkgs;
with utils;

let

  makeJobScript = name: text:
    let
      scriptName = replaceChars [ "\\" "@" ] [ "-" "_" ] (shellEscape name);
      out = pkgs.writeTextFile {
        # The derivation name is different from the script file name
        # to keep the script file name short to avoid cluttering logs.
        name = "unit-script-${scriptName}";
        executable = true;
        destination = "/bin/${scriptName}";
        text = ''
          #!${pkgs.runtimeShell} -e
          ${text}
        '';
        checkPhase = ''
          ${pkgs.stdenv.shell} -n "$out/bin/${scriptName}"
        '';
      };
    in
    "${out}/bin/${scriptName}";

in

{
  home.packages = [
    acpi
    libnotify
  ];

  systemd.user =
    let
      batteryCheck = "battery-check";
    in
    {
      services = {
        "${batteryCheck}" = {
          Unit = {
            Description = "Battery level notification";
          };
          Service = {
            ExecStart = makeJobScript "${batteryCheck}-start" ''
              POWEROFF_THRESHOLD=3
              WARN_THRESHOLD=10
              DISCHARGING="$(${acpi}/bin/acpi -b | head -n 1 | grep Discharging | wc -l)"

              export DISPLAY=:0

              BATTERY_LEVEL=$(${acpi}/bin/acpi  -b | grep -P -o '[0-9]+(?=%)')

              if [ $BATTERY_LEVEL -le $POWEROFF_THRESHOLD -a $DISCHARGING = "1" ]
              then
                  ${libnotify}/bin/notify-send -u critical -t 60000 "Going to shutdown in 1 min!" "Battery level is $BATTERY_LEVEL%!"
                  shutdown -h +1
              elif [ $BATTERY_LEVEL -le $WARN_THRESHOLD -a $DISCHARGING = "1" ]
              then
                  ${libnotify}/bin/notify-send -u critical -t 60000 "Battery low" "Battery level is $BATTERY_LEVEL%!"
              fi
            '';
          };
        };
      };

      timers = {
        "${batteryCheck}" = {
          Unit = {
            Description = "Battery level notification timer";
          };
          Timer = {
            OnBootSec = "1m";
            OnUnitInactiveSec = "1m";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
}
