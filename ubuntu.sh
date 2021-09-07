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
pip install -U virtualenv argcomplete awscli
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# zsh
sudo apt install -y zsh
chsh -s $(which zsh)
rm -rf ~/.oh-my-zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.zshrc > ~/.zshrc

# docker
sudo apt install -y docker docker-compose
sudo usermod -a -G docker ${USER}

# snap
sudo snap install slack --classic
sudo snap install sublime-text --classic
sudo snap install spotify
sudo snap install ngrok
sudo snap install zoom-client

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc

brew install mkcert

sudo apt install -y htop nmap cmake
echo "Download JetBrains toolbox:"
echo "https://www.jetbrains.com/toolbox/app/"

# aws
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc
aws configure

# shortcuts
echo 'alias upgrade="sudo apt update && sudo apt dist-upgrade && sudo apt autoremove && sudo snap refresh && brew update && brew upgrade"' >> ~/.zshrc
