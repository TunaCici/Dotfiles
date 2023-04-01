#!/bin/bash

INSTALL_IMAGE_PATH="/path/to/image"
VM_DISK_PATH="/path/to/vm/disk/qcow2"

args=(
	# Type & VM Engine
	-accel hvf
	-M virt,highmem=off
	
	# System Specs
	-name MyFirstQemu
	-m 2G 
	-cpu host
	-smp 2
	
	# UEFI
	-drive file=QEMU_EFI-pflash.raw,if=pflash,format=raw,readonly=on
	-drive file=vars-template-pflash.raw,if=pflash,format=raw
	
	# Disks
	-drive if=none,file=${INSTALL_IMAGE_PATH},format=qcow2,id=hd0
	-device virtio-blk-device,drive=hd0,serial="main_disk" 
	-cdrom ${VM_DISK_PATH}
	
	# Devices
	-device usb-ehci 
	-device usb-kbd 
	-device usb-mouse 
	-usb

	# Network
	-device virtio-net-device,netdev=net0
	-netdev user,id=net0

	# Display
	-device virtio-gpu
	-vga none

	# Serial & Terminal
	-serial stdio
)

qemu-system-aarch64 "${args[@]}"
