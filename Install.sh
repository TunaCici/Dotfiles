#!/usr/bin/env sh

# Description: Initialize the OS by installing the required packages. \
#              The default package manager is 'apt'. \
# Supported package managers: [1] apt, [2] pacman and [3] yum.

PKG_MGR="UNKNOWN"

function err_pck_mgr() {
    echo "[x]: Package manager not found." >&2
    exit 1
}

function set_pck_mgr() {
    if [ -x "$(command -v apt)" ]; then
        PKG_MGR="apt"
    elif [ -x "$(command -v pacman)" ]; then
        PKG_MGR="pacman"
    elif [ -x "$(command -v yum)" ]; then
        PKG_MGR="yum"
    else
        err_pck_mgr
    fi
}

function update_pck_lst() {
    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt update
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -Sy
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum update
    else
        err_pck_mgr
    fi
}

function install_exa() {
    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install exa -y
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S exa --noconfirm
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install exa -y
    else
        err_pck_mgr
    fi
}

function install_httpie() {
    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install httpie
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S httpie
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install httpie
    else
        err_pck_mgr
    fi
}

# 1. Set package manager.
echo "[*] Checking for available package managers"
set_pck_mgr
echo "[x] Package manager set to: ${PKG_MGR}"

# 2. Update upstream package lists.
echo "[*] Updating upstream package list"
update_pck_lst
echo "[x] Updated upstream package list"

# 3. Install packages.
echo "[*] Installing exa and httpie"
install_exa
install_httpie

# 4. Test packages.
if [ -x "$(command -v exa)" ]; then
    echo "[x]: exa installed successfully."
else
    echo "[x]: exa installation failed." >&2
    exit 1
fi

if [ -x "$(command -v http)" ]; then
    echo "[x]: httpie installed successfully."
else
    echo "[x]: httpie installation failed." >&2
    exit 1
fi

