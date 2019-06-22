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
1. Follow [this guide](https://stackoverflow.com/questions/8588768/how-do-i-avoid-the-specification-of-the-username-and-password-at-every-git-push) to avoid having to authenticate yourself for every git action: )
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

# Create a custom (.net core) docker image
NOTE: These instructions should be done a separate machine with the following requirements:
- Windows 10 pro (required for docker)
- Docker installed
- Visual Studio IDE

1. Create a .net core "Hello world!" project.
2. Right click the project and choose "Add/Container Orchestrator Support".
3. Choose Docker as container orchestrator in the popup.
4. Docker file adjustments (TO BE EXPANDED ON!)
  a. To add support to run in linux environment make sure the first line is ``FROM microsoft/dotnet:2.2-runtime-stretch-slim-arm32v7 AS base``
5. Save the project.
6. Open the terminal.
7. Run the command ``docker build <path_to_docker_file> --tag="<image_name>:<image_tag>``
8. <Login to docker hub etc?>
9. Run the command ``docker push <image_name>:<image_tag>``

# Pull and run the custom docker image

1. Open the the terminal on the rasberry.
2. Enter the command ``docker run <image_name>:<image_tag>``

## 

