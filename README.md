## Automatic Power Profile and Screen Brightness Adjustments for Pop!_OS

This script allows for automatic adjustments to power profiles and screen brightness on Pop!_OS based on whether the computer is on AC power or battery. Here are the steps to set it up:

1. Download the script and make it executable.
2. Edit the script to reflect your hardware backlight controller and your desired screen brightness (see note below).
3. Set up a cron job to execute the script every minute as root:

    ```
    sudo crontab -u root -e
    ```

    Add the following line to the file, substituting in the absolute path to the script:

    ```
    * * * * * (absolute path to the update_system76_power.sh script)
    ```

4. Save and exit the cron job file.
5. Enjoy automatic power and screen brightness adjustments!

### Note:

- To find your hardware backlight controller, you can run the command `ls /sys/class/backlight/` in your terminal.
- To find your ideal screen brightness level, you can experiment with different values by running the command `echo {value} > /sys/class/backlight/{backlight controller}/brightness` in your terminal. The maximum value can be found by running the command `cat /sys/class/backlight/{backlight controller}/max_brightness` in your terminal.