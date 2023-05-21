#!/bin/sh

# Set a counter to keep track of the number of iterations
i=0

# Loop for 60 iterations (about a minute)
while [ $i -lt 60 ]; do

    # Get the current power profile, brightness and max brightness level
    current_profile=$(system76-power profile | grep -o 'Performance\|Battery\|Balanced')
    current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
    max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)

    # If on AC power and not in performance mode, switch to performance mode and increase brightness if necessary
    if on_ac_power && [ "$current_profile" != "Performance" ]; then

        system76-power profile performance

        # If brightness is lower than 20 percent then increase it to 40 percent
        if [ "$current_brightness" -lt $((max_brightness * 20 / 100)) ]; then
            echo $((max_brightness * 40 / 100)) >/sys/class/backlight/intel_backlight/brightness
        fi

    # If on battery power and not in battery mode, switch to battery mode and decrease brightness if necessary
    elif ! on_ac_power && [ "$current_profile" != "Battery" ]; then

        system76-power profile battery

        # If you have an Intel CPU uncomment the below lines for better power savings.
        # Lower-end devices benefit from max_perf_pct being set at 20 percent. However, you should experiment with different
        # values to find your sweet spot. Try to keep it below 50.

        #echo 0 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
        #echo 20 > /sys/devices/system/cpu/intel_pstate/max_perf_pct

        # If brightness is greater than 50 percent then decrease it to 30 percent
        if [ "$current_brightness" -gt $((max_brightness * 50 / 100)) ]; then
            echo $((max_brightness * 30 / 100)) >/sys/class/backlight/intel_backlight/brightness
        else
            # Switching to battery mode automatically sets the brightness at 10 percent, this is to counter that
            echo "$current_brightness" >/sys/class/backlight/intel_backlight/brightness
        fi

    fi

    # Wait for 1 second before continuing to the next iteration
    sleep 1

    # Increment the counter
    i=$((i + 1))
done
