#!/usr/bin/env bash

reminder_txt=$(zenity --entry --title="Set Reminder" --text="Enter reminder text: ")

if [[ -z "$reminder_txt" ]]; then
    notify-send "No text entered" --urgency=critical
    exit 1
fi

reminder_time=$(zenity --entry --title="Set Reminder" --text="Enter reminder time (HH:MM): ")

if [[ -z "$reminder_time" ]]; then
    notify-send "Time not set" --urgency=critical
    exit 1
fi

current_time=$(date +%s)
target_time=$(date -d "$reminder_time" +%s) 

if [[ $target_time -le $current_time ]]; then
  target_time=$((target_time + 86400))
fi

time_diff=$((target_time - current_time))

reminder_time_format=$(date -d "$reminder_time" +%I:%M\%p)
notify-send "Reminder set for $reminder_time_format"
sleep $time_diff && notify-send "Reminder: $reminder_txt"
