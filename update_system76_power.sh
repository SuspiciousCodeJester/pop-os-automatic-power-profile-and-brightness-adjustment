#!/bin/sh

# Set a counter to keep track of the number of iterations
i=0

# Loop for 60 iterations (about a minute)
while [ $i -lt 60 ]; do

    # Get the current power profile and brightness level
    current_profile=$(system76-power profile | grep -o 'Performance\|Battery\|Balanced')
    current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

    # If on AC power and not in performance mode, switch to performance mode and increase brightness if necessary
    if on_ac_power && [ "$current_profile" != "Performance" ]; then

        system76-power profile performance

        if [ "$current_brightness" -lt 1500 ]; then
            echo 3000 > /sys/class/backlight/intel_backlight/brightness
        fi

    # If on battery power and not in battery mode, switch to battery mode and decrease brightness if necessary
    elif ! on_ac_power && [ "$current_profile" != "Battery" ]; then

        system76-power profile battery

        if [ "$current_brightness" -gt 3750 ]; then
            echo 2250 > /sys/class/backlight/intel_backlight/brightness
        else
            # Switching to battery mode automatically sets the brightness at 10%, this is to counter that
            echo "$current_brightness" > /sys/class/backlight/intel_backlight/brightness
        fi

    fi

    # Wait for 1 second before continuing to the next iteration
    sleep 1

    # Increment the counter
    i=$((i + 1))
done