#!/usr/bin/env bash

set -e
set -o xtrace

sudo apt update
sudo apt dist-upgrade -y

sudo apt install -y curl

# graphics
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt dist-upgrade -y

# git
sudo apt install -y git
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.gitconfig > ~/.gitconfig

# terminator
sudo apt install -y terminator
mkdir -p ~/.config/terminator
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.config/terminator/config > ~/.config/terminator/config

# fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# GDB
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.gdbinit > ~/.gdbinit

# python
sudo apt install -y python3-pip python3-dev
pip3 install -U virtualenv

# npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node

# zsh
sudo apt install -y zsh
rm -rf ~/.oh-my-zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.zshrc > ~/.zshrc

# docker
sudo apt install -y docker docker-compose
sudo usermod -a -G docker ${USER}

# snap
sudo apt install -y snapd
sudo snap install slack --classic
sudo snap install sublime-text --classic
sudo snap install spotify
sudo snap install ngrok

# brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc

# misc
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

sudo apt install -y htop nmap cmake
echo "Download JetBrains toolbox:"
echo "https://www.jetbrains.com/toolbox/app/"

# aws
pip3 install -U awscli
aws configure
