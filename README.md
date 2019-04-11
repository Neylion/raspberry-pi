# How to set up the Raspberry Pi for Docker
This guide has been setup for Raspberry Pi 3B+ with NOOBS pre-installed. V1 written 2019-04-07.
The github repo: https://github.com/Neylion/raspberry-pi

## First time
1. Assemble the Raspberry pi and insert the SD card with NOOBS on it.
2. Connect a keyboard, mouse and screen to the RPI.
3. Do not connect it to the internet yet.
4. Connect the Raspberry Pi to the power source (Raspbian will automatically be installed).

If you later want to start over, this is how you make a “factory reset”:

1. Restart the machine (power off/on or `sudo reboot`)
2. During bootup, repeatedly press shift (If you succeeds Noobs menu will be loaded, if you fail the raspberry will boot like normal and you can start over at #1).
3. Choose Raspbian.
4. Click install

## Basic Raspbian setup
1. Enter the menu -> Preferences/Raspberry Pi Configuration.
  1. Go to the tab “Localisation”.
    1. Change to the appropriate keyboard layout.
    2. Change to the appropriate WiFi Country.
  2. Go to the tab “System”.
    1. Change Password.
2. Connect to a wifi in top right corner.

## Setup Git and clone this repo.
1. Open up a terminal
2. (Follow this guide to avoid having to authenticate yourself for every git action: https://stackoverflow.com/questions/8588768/how-do-i-avoid-the-specification-of-the-username-and-password-at-every-git-push)
2. Manually run the command lines in file ``01-git-init.sh``.
3. Manually run the command lines in file ``clone-raspberry-pi-repo.sh``

# Install docker
# This script is meant for quick & easy install via:
#   $ curl -fsSL https://get.docker.com -o get-docker.sh
#   $ sh get-docker.sh
