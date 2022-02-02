#!/usr/bin/env bash
# Bluetooth info

has_headset() {
    if ! command -v bluetoothctl &> /dev/null; then
        false
        return
    fi
    if [ ! -e /sys/class/bluetooth ]; then
        false
        return
    fi
    [[ $(bluetoothctl -- list | grep -Po "Controller [0-9A-F]{2}(:[0-9A-f]{2}){5} .+ \[default\]" | wc -l) > 0 ]]
}

headset() {
  device="04:5D:4B:97:5D:55"
  name="$(bluetoothctl -- info $device | grep "Name" | cut -d ":" -f 2 | tr -d '[:space:]')"
  connected="$(bluetoothctl -- info $device | grep "Connected" | cut -d ":" -f 2 | tr -d '[:space:]')"
  if [[ "$connected" != 'yes' ]]; then
    name="-"
  fi
  echo -e " $name"
}

