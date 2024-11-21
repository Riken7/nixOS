#!/usr/bin/env bash

# Get the volume of the active sink
volume_info=$(wpctl get-volume @DEFAULT_SINK@)

volume=$(echo "$volume_info" | awk '{print $2}') 
mute_status=$(echo "$volume_info" | awk '{print $3}')
# Format output based on volume
if [[ "$volume" == "0.00" || "$mute_status" == "[MUTED]" ]]; then
    output=" :Muted" 
else
    output=" :${volume}"
fi

mic_info=$(wpctl get-volume @DEFAULT_SOURCE@)
mic_volume=$(echo "$mic_info" | awk '{print $2}')
mic_mute_status=$(echo "$mic_info" | awk '{print $3}')
if [[ "$mic_volume" == "0.00" || "$mic_mute_status" == "[MUTED]" ]]; then
    output="$output |  :Muted" 
else
    output="$output | :${mic_volume}"
fi

echo "$output"
