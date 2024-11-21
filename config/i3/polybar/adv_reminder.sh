
#!/usr/bin/env bash

REMINDER_FILE="$HOME/reminders.txt"

# Function to display existing reminders
view_reminders() {
    if [[ -f "$REMINDER_FILE" && -s "$REMINDER_FILE" ]]; then
        zenity --list --title="View Reminders" --column="Reminder Text" --column="Time" \
        $(awk -F '|' '{print $1, $2}' "$REMINDER_FILE")
    else
        zenity --info --text="No reminders set."
    fi
}

# Function to add a new reminder
add_reminder() {
    # Prompt for reminder text
    reminder_txt=$(zenity --entry --title="Set Reminder" --text="Enter reminder text:")

    if [[ -z "$reminder_txt" ]]; then
        zenity --error --text="No reminder text entered."
        exit 1
    fi

    # Prompt for reminder time (12-hour format: HH:MM)
    reminder_time=$(zenity --entry --title="Set Reminder" --text="Enter reminder time (HH:MM):")

    if [[ -z "$reminder_time" ]]; then
        zenity --error --text="Time not set."
        exit 1
    fi

    # Prompt for AM/PM selection using zenity radio buttons
    am_pm=$(zenity --list --radiolist --title="Select AM/PM" --column="Select" --column="AM/PM" \
        TRUE "AM" FALSE "PM")

    if [[ -z "$am_pm" ]]; then
        zenity --error --text="AM/PM not selected."
        exit 1
    fi

    # Combine time with AM/PM (e.g., "02:30 AM" or "11:45 PM")
    full_time="$reminder_time $am_pm"

    # Convert the 12-hour time (with AM/PM) to 24-hour format for internal processing
    reminder_time_24hr=$(date -d "$full_time" +%H:%M)

    if [[ $? -ne 0 ]]; then
        zenity --error --text="Invalid time format. Please use HH:MM AM/PM format."
        exit 1
    fi

    # Store reminder in file (text | time)
    echo "$reminder_txt | $reminder_time_24hr" >> "$REMINDER_FILE"

    # Notify user that the reminder was set
    zenity --info --text="Reminder set for $reminder_txt at $full_time."
}

# Function to delete a reminder
delete_reminder() {
    if [[ ! -f "$REMINDER_FILE" || ! -s "$REMINDER_FILE" ]]; then
        zenity --info --text="No reminders to delete."
        return
    fi

    reminder_to_delete=$(zenity --list --title="Delete Reminder" --column="Reminder Text" --column="Time" \
        $(awk -F '|' '{print $1, $2}' "$REMINDER_FILE"))
    
    if [[ -z "$reminder_to_delete" ]]; then
        zenity --info --text="No reminder selected for deletion."
        return
    fi

    # Remove selected reminder from the file
    grep -v "^$reminder_to_delete" "$REMINDER_FILE" > "$REMINDER_FILE.tmp" && mv "$REMINDER_FILE.tmp" "$REMINDER_FILE"
    zenity --info --text="Reminder deleted."
}
case "$1" in
    "add")
        add_reminder
        ;;
    "view")
        view_reminders
        ;;
    *)
        zenity --error --text="Invalid argument. Use 'add' or 'view'."
        exit 1
        ;;
esac


