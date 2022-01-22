#!/usr/bin/env bash
# Battery power indicator

has_batt() {
    if ! command -v acpi &> /dev/null; then
        false
        return
    fi
    if [ ! -e /sys/class/power_supply ]; then
        false
        return
    fi
    [[ $(acpi -b 2> /dev/null | grep "Battery" | wc -l) > 0 ]]
}

batt() {
  batt="$(acpi -b 2> /dev/null | head -n 1 | grep -Po "[[:digit:]]{1,3}%")"
  echo -e " $batt"
}

