## Automatic Power Profile and Screen Brightness Adjustments for Pop!_OS

This script allows for automatic adjustments to power profiles and screen brightness on Pop!_OS based on whether the computer is on AC power or battery. Here are the steps to set it up:

1. Download the script and make it executable.

     ```
    sudo chmod +x update_system76_power.sh
    ```

2. Edit the script to reflect your hardware backlight controller (see note below).

3. Set up a cron job to execute the script every minute as root:

    ```
    sudo crontab -u root -e
    ```

    Add the following line to the file, substituting in the absolute path to the script:

    ```
    * * * * * (absolute path to the update_system76_power.sh script)
    ```

4. Save and exit the cron job file.

### Note

- To find your hardware backlight controller, you can run the command `ls /sys/class/backlight/` in your terminal.

- If you fail to properly edit the script, it may not work as intended.

- For advanced users, you can add the script to execute on startup and make sure it runs reliably on startup. I used cronjobs to guarantee its execution.
