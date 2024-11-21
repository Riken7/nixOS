#!/usr/bin/env bash

Timer =$(zenity --entry --title="Set Timer" --text="Enter time in seconds")

if ![[ "$Timer" =~ ^[0-9]+$ ]]; then
  notify-send "Invalid input"
  exit 1
fi

while [$Timer -gt 0]; do
  sleep 1
  Timer=$((Timer-1))
  echo $Timer
done

pw-play /home/rik/Downloads/the_big_adventure.mp3
notify-send "Time up!"

