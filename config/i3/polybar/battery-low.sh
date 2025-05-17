#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"
capacity=$(cat $BAT_PATH/capacity)
status=$(cat $BAT_PATH/status)
WARN_FILE="/tmp/polybar_battery_warned"

if [[ "$status" == "Discharging" && $capacity -le 20 ]]; then
  if [[ ! -f $WARN_FILE ]]; then
    notify-send --urgency=critical "Battery Low" "Battery is at $capacity%."
    touch $WARN_FILE
  fi
else
  rm -f $WARN_FILE
fi

echo ""

