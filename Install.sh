#!/usr/bin/env sh

# Description: Initialize the OS by installing the required packages. \
#              The default package manager is 'apt'. \
# Supported package managers: [1] apt, [2] pacman and [3] yum.

PKG_MGR="UNKNOWN"

function lz_err_pck_mgr() {
    echo "[LZ_ERR]: Package manager not found." >&2
    exit 1
}

function lz_set_pck_mgr() {
    if [ -x "$(command -v apt)" ]; then
        PKG_MGR="apt"
    elif [ -x "$(command -v pacman)" ]; then
        PKG_MGR="pacman"
    elif [ -x "$(command -v yum)" ]; then
        PKG_MGR="yum"
    else
        lz_err_pck_mgr
    fi
}

function lz_update_pck_lst() {
    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt update
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -Sy
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum update
    else
        lz_err_pck_mgr
    fi
}

function lz_install_exa() {
    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install exa -y
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S exa --noconfirm
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install exa -y
    else
        lz_err_pck_mgr
    fi
}

function lz_install_httpie() {
    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install httpie
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S httpie
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install httpie
    else
        lz_err_pck_mgr
    fi
}

# 1. Set package manager.
lz_set_pck_mgr

# 2. Update upstream package lists.
lz_update_pck_lst

# 3. Install packages.
lz_install_exa
lz_install_httpie

# 4. Test packages.
if [ -x "$(command -v exa)" ]; then
    echo "[LZ]: exa installed successfully."
else
    echo "[LZ_ERR]: exa installation failed." >&2
    exit 1
fi

if [ -x "$(command -v http)" ]; then
    echo "[LZ]: httpie installed successfully."
else
    echo "[LZ_ERR]: httpie installation failed." >&2
    exit 1
fi
