# About
Collection of multiple tools, configs and scripts I use for my daily work. \
This repository is mainly for my own use, but feel free to use it as you wish. \
There are multiple branches for different purposes, see below for more information.

## Directory Structure
```
|- /Scripts -> Scripts for different purposes.
|---- scripts.sh -> Functions for zsh.
|---- start_ubuntu_server.sh -> Start Ubuntu Server 22.04 (On QEMU).
|- /RC_Files -> RC/Profile files for different shells.
|---- .zshrc -> For zsh.
|---- .vimrc -> For VIM.
|- README.md -> This file.
|- Install.sh -> Script for setting things up. (Linux & macOS only)
```

## Scripts
Many shell commands require a lot of typing, so I created some scripts to make my life easier.
These scripts are located under the `Scripts` directory. \
\
Here is a list of all the functions.
```bash
lz_ip() # Print network interfaces and their IPv4 addresses.
```

## QEMU Emulation/Virtualization on Apple Silicons
Below is a couple of commands that installs QEMU and creates a Ubuntu Server 22.04.

TODO: Better description & guide \
TODO: Add more start scripts \
TODO: Setup x86_64 emulation \


```bash
# Install QEMU
$ brew install qemu

# Check if QEMU is installed
$ qemu-system-aarch64 --version

# Download the OS image (for example: Ubuntu Server)
$ wget https://releases.ubuntu.com/jammy/ubuntu-22.04.1-live-server-amd64.iso

# Create VM Disk named 'disk.qcow2' with size 16GB
$ qemu-img -f qcow2 disk.qcow2 16G

# Retrieve the AARCH64 UEFI firmware from the EDK-II project
# https://rpmfind.net/linux/rpm2html/search.php?query=edk2-aarch64

# Start the server using the bash script
$ ./Scripts/start_ubuntu_server.sh
```
