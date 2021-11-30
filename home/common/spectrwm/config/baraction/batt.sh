#!/usr/bin/env bash
# Battery power indicator

has_batt() {
    if command -v acpi &> /dev/null; then
        false
    fi
    [[ $(acpi -b | grep "Battery" | wc -l) > 0 ]]
}

batt() {
  batt="$(acpi -b | head -n 1 | grep -Po "[[:digit:]]{1,3}%")"
  echo -e " $batt"
}

