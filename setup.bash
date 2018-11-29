#!/bin/bash

set -ex

sudo apt update

# Fish ppa
sudo add-apt-repository ppa:fish-shell/nightly-master -y

# Misc packages
sudo apt update
sudo apt install -y git \
                    wget \
                    curl \
                    build-essential \
                    cmake \
                    python3-pip \
                    python-dev \
                    python3-dev \
                    terminator \
                    ranger \
                    tree \
                    fish

# Fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c "fisher add edc/bass"

# Powerline
sudo -H pip3 install powerline-status
sudo -H pip3 install powerline-gitstatus


# Powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Everything else
cp -r .vimrc .vim .xbindkeysrc .gitconfig .config .bashrc .bash_aliases $HOME
