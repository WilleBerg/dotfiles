#!/bin/bash

NEOVIM_VERSION="0.10.4"
NEOVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim-linux64.tar.gz"

echo "Starting install script..."

if [ "$(id -u)" -eq 0 ]; then
    echo "This script should not be run as root" >&2
    exit 1
fi

USR_HOME=$HOME
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID="$ID"
else
    echo "Cannot determine the Linux distribution"
    exit 1
fi

case $DISTRO_ID in
    manjaro|arch)
        echo "Running on Manjaro or Arch Linux"
        sudo pacman -Syu
        sudo pacman -S stow git tmux kitty lua51 luarocks base-devel python-pynvim python-pip neovim zoxide
        ;;
    ubuntu)
        echo "Running on Ubuntu"
        sudo apt update && sudo apt upgrade
        sudo apt install nala
        sudo nala install tmux zsh bat curl wget ripgrep fzf stow git net-tools gcc python3-pip lua5.1 python3-pynvim liblua5.1-dev brightnessctl xbindkeys
        # If brightness control doesnt work in i3
        # sudo gpasswd -a <username> video

        echo "======================= INSTALLING OHMYZSH ======================="
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "=======================    INSTALL DONE    ======================="

        echo "Backing up old rc files"
        mv $USR_HOME/.zshrc $USR_HOME/.zshrc.bak
        mv $USR_HOME/.bashrc $USR_HOME/.bashrc.bak
        cd $USR_HOME/dotfiles
        stow .
        echo "alias l=\"ls -la\"" >> $USR_HOME/.bashrc
        echo "alias l=\"ls -la\"" >> $USR_HOME/.zshrc

        echo "======================= INSTALLING NEOVIM  ======================="
        echo "Installing Neovim $NEOVIM_VERSION"
        mkdir $USR_HOME/Downloads
        wget -O $USR_HOME/Downloads/nvim-linux64.tar.gz $NEOVIM_DOWNLOAD_URL
        tar xzvf $USR_HOME/Downloads/nvim-linux64.tar.gz
        mkdir $USR_HOME/sw
        mv nvim-linux64 $USR_HOME/sw
        echo 'export PATH="$HOME/sw/nvim-linux64/bin:$PATH"' >> $USR_HOME/.bashrc
        echo 'export PATH="$HOME/sw/nvim-linux64/bin:$PATH"' >> $USR_HOME/.zshrc
        cd $USR_HOME/dotfiles/.config/nvim
        git clone https://github.com/WilleBerg/neovim-config-lua.git . --depth 1
        echo "=======================    INSTALL DONE    ======================="

        cd $USR_HOME 
        echo "======================= INSTALLING ZOXIDE  ======================="
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
        echo 'eval "$(zoxide init zsh)"' >> .zshrc
        echo 'eval "$(zoxide init bash)"' >> .bashrc
        echo "=======================    INSTALL DONE    ======================="

        read -p "Install kitty terminal emulator? [y/n] " choice

        if [[ $choice == "y" || $choice == "Y" ]]; then
            # Install kitty
            curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

            read -p "Desktop integration for kitty? [y/n]" desktop_choice
            if [[ $desktop_choice =~ ^[yY]$ ]]; then
                # Fix icons and stuff
                
                # Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
                # your system-wide PATH)
                ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
                # Place the kitty.desktop file somewhere it can be found by the OS
                cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
                # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
                cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
                # Update the paths to the kitty and its icon in the kitty desktop file(s)
                sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
                sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
                # Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
                echo 'kitty.desktop' > ~/.config/xdg-terminals.list
            fi
        elif [[ $choice == "n" || $choice == "N" ]]; then
            read -p "Install alacritty terminal emulator? [y/n] " choice
            if [[ $choice == "y" || $choice == "Y" ]]; then
                echo "TODO"
            fi
        fi

        ;;
    *)
        echo "Unsupported distribution: $DISTRO_ID"
        echo "Add it to the script"
        exit 1
        ;;
esac

echo "=======================  INSTALLING RUST   ======================="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "=======================    INSTALL DONE    ======================="

echo "Changing cat to batcat"
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

echo "Adding $USR_HOME/.local/bin to rc files"
echo 'export PATH="$USR_HOME/.local/bin:$PATH"' >> $USR_HOME/.bashrc
echo 'export PATH="$USR_HOME/.local/bin:$PATH"' >> $USR_HOME/.zshrc

echo "Installing TMP"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing node version manager"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source $USR_HOME/.zshrc
nvm install node
npm install -g neovim


echo "Test neovim. If :checkhealth has a bunch of issues with highligting, try :TSUpdate"
