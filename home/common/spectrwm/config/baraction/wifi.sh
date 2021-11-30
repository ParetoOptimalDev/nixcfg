#!/usr/bin/env bash
## Wifi signal indicator

INTERFACE="wlp82s0"

has_wifi() {
    [ -d /sys/class/net/$INTERFACE ]
}

wifi() {
    local quality
    # If the wifi interface exists but no connection is active, "down" shall be displayed.
    if [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
        quality='down'
    fi
    quality=$(grep "$INTERFACE" /proc/net/wireless | awk '{ printf "%d%", int($3 * 100 / 70) }')
    echo -e "  $quality"
}

