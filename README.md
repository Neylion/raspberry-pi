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

## Setup remote access through VNC

### Enabling the VNC Server on Raspberry Pi
1. Open up a terminal
2. Use the command ``sudo raspi-config``.
3. Enable VNC (Navigate using arrows & enter)
    1. Choose Interfacing Options
    2. Choose VNC
    3. Choose <Yes>
4. Find the IP for the raspberry pi by using the command ``hostname -I``

### Accessing the Pi (Windows)
1. Download [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) on your computer.
2. Open VNC Viewer
3. Enter your raspberry pi IP.
4. Enter your raspberry pi user credentials.

## Setup Git and clone this repo.
1. Follow [this guide](https://stackoverflow.com/questions/8588768/how-do-i-avoid-the-specification-of-the-username-and-password-at-every-git-push) to avoid having to authenticate yourself for every git action
2. Open up a terminal
3. sh git-init.sh > git-init.log
4. sh clone-raspberry-pi-repo.sh > clone-raspberry-pi-repo.log

## Install docker

curl -fsSL https://get.docker.com | sh | tee get-docker.log

## Give user pi access to docker

WARNING: Adding a user to the "docker" group will grant the ability to run containers which can be used to obtain root privileges on the docker host.

1. sudo usermod -aG docker pi
2. Logout and login to take effect

## Verify docker installation

1. docker --version | tee docker-version.log
2. docker info | tee docker-info.log
2. docker run hello-world
3. Verify that a (long) hello message is displayed

This description is based on [docs.docker.com](https://docs.docker.com/get-started/)

## Create a custom (.net core) docker image
NOTE: These instructions should be done a separate machine with the following requirements:
- Windows 10 pro (required for docker)
- Docker installed
- Visual Studio IDE

1. Create a .net core "Hello world!" project.
2. Right click the project and choose "Add/Container Orchestrator Support".
      1. Choose Docker as container orchestrator in the popup.
      2. Choose Linux in the popup.
4. Docker file adjustments (TO BE EXPANDED ON!)
      1. To add support to run in linux environment make sure the first line is ``FROM microsoft/dotnet:2.2-runtime-stretch-slim-arm32v7 AS base``
5. Save the project.
6. Open a terminal.
7. Run the command ``docker build <path_to_docker_file> --tag="<image_name>:<image_tag>"``
8. Login to docker hub using ``docker login`` and following the instructions
9. Run the command ``docker push <image_name>:<image_tag>``

Now the image you created is available on dockerhub and anyone (?) can download and run it.

## Pull and run the custom docker image

1. Open the a terminal on the rasberry.
2. Enter the command ``docker run <image_name>:<image_tag>``

## Using environment variables

### Add environment variable - WINDOWS
1. Go to "Control Panel/System and Security/System and click "Advanced system settings" on the left
2. Click the "Environment Variables..." button on the popup window.
3. Click add in the user section and enter your variable name and value.
4. Click "OK" on all the popup windows related to this action.
5. You are now done but need to run a restart to make the variables available for use.

### Add environment variable - Raspbian
Pre-requisite: For these steps "vim" is used as text editor. You can install it using the command ``sudo apt-get install vim``.

1. Open up a terminal.
2. Enter the command ``sudo vim /etc/profile``.
3. Click the "i"-key to enter insert mode.
4. At the bottom of the file, enter "export <VARIABLE_NAME>="<VARIABLE_VALUE>" (You can repeat this on multiple rows to add multiple variables).
5. Press the "esc"-key and write ``:wq`` to save the file.
6. You are now done but need to run a restart to make the variables available for use.
7. (OPTIONAL) You can confirm that the environment variable has been created properly by going to a terminal and using the command ``printenv <VARIABLE_NAME>``.

### Get the variable value in the code (.net core):
1. Go to the code location where you want to use the variable value.
2. Use Environment.GetEnvironmentVariable("<VARIABLE_NAME>").

### Making the variables available in a docker container
To be able to fetch the variables from a docker container we must pass them in when running the image. This can be done in a number of ways but for these steps the "--env-file"-option is used.

1. Open a terminal.
2. Create the env.list file.
      1. Use the command ``cd``.
      2. Use the command ``sudo vim Documents/env.list``
      3. Enter the variable names (one per row) that you want to be able to use in the container.
3. Run the image but add ``--env-file env.list`` before the image name&tag. ``docker run --env-file env.list <image_name>:<image_tag>``