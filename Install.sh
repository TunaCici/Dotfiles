#!/usr/bin/env bash

# Description: Initialize the OS by installing the required packages. \
#              The default package manager is 'apt'. \
# Supported package managers: [1] apt, [2] pacman and [3] yum.

PKG_MGR="UNKNOWN"

function print_msg() {
    local msg="$1"
    local symbol="$2"
    local timestamp=$(date +"%T")

    printf "[%s] " "$timestamp"
    
    if [ "$symbol" == "x" ]; then
        printf "[\e[32m%s\e[0m] %s\n" "$symbol" "$msg"
    elif [ "$symbol" == "*" ]; then
        printf "[\e[33m%s\e[0m] %s\n" "$symbol" "$msg"
    elif [ "$symbol" == "!" ]; then
        printf "[\e[31m%s\e[0m] %s\n" "$symbol" "$msg"
    else
        printf "[%s] %s\n" "$symbol" "$msg" 2> stderr
    fi
} 

function err_pck_mgr() {
    print_msg "Unknown package manager." "!"
    exit 1
}

function set_pck_mgr() {
    # Check OSTYPE and package manager
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -x "$(command -v apt)" ]; then
            PKG_MGR="apt"
        elif [ -x "$(command -v pacman)" ]; then
            PKG_MGR="pacman"
        elif [ -x "$(command -v yum)" ]; then
            PKG_MGR="yum"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if [ -x "$(command -v brew)" ]; then
            PKG_MGR="brew"
        fi
    fi

    if [ "$PKG_MGR" == "UNKNOWN" ]; then
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
    elif [ "$PKG_MGR" == "brew" ]; then
        brew update
    fi
}

function install_exa() {
    if [ -x "$(command -v exa)" ]; then
        print_msg "exa already installed." "x"
        return
    fi

    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install exa -y
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S exa --noconfirm
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install exa -y
    elif [ "$PKG_MGR" == "brew" ]; then
        brew install exa
    fi
}

function install_httpie() {
    if [ -x "$(command -v http)" ]; then
        print_msg "httpie already installed." "x"
        return
    fi

    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install httpie
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S httpie
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install httpie
    elif [ "$PKG_MGR" == "brew" ]; then
        brew install httpie
    fi
}

function install_vim() {
    if [ -x "$(command -v vim)" ]; then
        print_msg "vim already installed." "x"
        return
    fi

    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install vim
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S vim
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install vim
    fi
}

function install_zsh() {
    if [ -x "$(command -v zsh)" ]; then
        print_msg "zsh already installed." "x"
        return
    fi

    if [ "$PKG_MGR" == "apt" ]; then
        sudo apt install zsh zsh-syntax-highlighting
    elif [ "$PKG_MGR" == "pacman" ]; then
        sudo pacman -S zsh zsh-syntax-highlighting
    elif [ "$PKG_MGR" == "yum" ]; then
        sudo yum install zsh zsh-syntax-highlighting
    fi
}

function setup_dot_files() {
    if [[ -f "$HOME/.zshrc" ]]; then
        print_msg ".zshrc already exists." "*"
        read -r -p "Overwrite? [y/N]: " overwrite
        if [ "$overwrite" == "y" ]; then
            cp ./RC_Files/.zshrc "$HOME"
            print_msg "Overwrote .zshrc to $HOME" "x"
        fi
    else
        cp ./RC_Files/.zshrc "$HOME"
        echo "[x] Copied .zshrc to $HOME"
    fi

    if [[ -f "$HOME/.vimrc" ]]; then
        print_msg ".vimrc already exists." "*"
        read -r -p "Overwrite? [y/N]: " overwrite
        if [ "$overwrite" == "y" ]; then
            cp ./RC_Files/.vimrc "$HOME"
            print_msg "Overwrote .vimrc to $HOME" "x"
        fi
    else
        cp ./RC_Files/.vimrc "$HOME"
        print_msg "Copied .vimrc to $HOME" "x"
    fi
}

function change_shell() {
    if [ "$SHELL" == "$(command -v zsh)" ]; then
        print_msg "Default shell already set to zsh." "x"
        return
    fi

    if [ -x "$(command -v chsh)" ]; then
        sudo chsh $(whoami) --shell "$(command -v zsh)"
    else
        print_msg "chsh not found. You need to change shell manually." "*"
        print_msg "Tip: You can edit /etc/passwd." "x"
    fi
}

# 1. Set package manager.
print_msg "Setting package manager..." "*"
set_pck_mgr
print_msg "Package manager set to $PKG_MGR." "x"

# 2. Update upstream package lists.
print_msg "Updating package lists..." "*"
update_pck_lst
print_msg "Package lists updated." "x"

# 3. Install packages.
print_msg "Installing packages..." "*"
install_exa
install_httpie
install_vim
install_zsh

# 4. Test packages.
if [ -x "$(command -v exa)" ]; then
    print_msg "exa installed successfully." "x"
else
    print_msg "exa installation failed." "*"
    exit 1
fi

if [ -x "$(command -v http)" ]; then
    print_msg "httpie installed successfully." "x"
else
    print_msg "httpie installation failed." "*"
    exit 1
fi

if [ -x "$(command -v vim)" ]; then
    print_msg "vim installed successfully." "x"
else
    print_msg "vim installation failed." "*"
    exit 1
fi

if [ -x "$(command -v zsh)" ]; then
    print_msg "zsh installed successfully." "x"
else
    print_msg "zsh installation failed." "*"
    exit 1
fi

# 5. Setup dotfiles
print_msg "Setting up dotfiles..." "*"
setup_dot_files
print_msg "Dotfiles setup complete." "x"

# 6. Change shell to zsh
print_msg "Changing default shell to zsh..." "*"
change_shell
print_msg "Default shell setup complete." "x"

print_msg "Sucessfully installed TunaCici/Dotfiles. Enjoy!" "x"
print_msg "Do not forget to restart your shell." "x"
