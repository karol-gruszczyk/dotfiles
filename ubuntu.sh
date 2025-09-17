#!/usr/bin/env bash

set -e
set -o xtrace

sudo apt update
sudo apt dist-upgrade -y

sudo apt install -y curl htop nmap cmake

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
sudo apt install -y python3-pip python3-dev python3-argcomplete
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# zsh
sudo apt install -y zsh
chsh -s $(which zsh)
rm -rf ~/.oh-my-zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.zshrc > ~/.zshrc

# docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -a -G docker ${USER}

# snap
sudo snap install slack
sudo snap install sublime-text --classic
sudo snap install spotify
sudo snap install ngrok
sudo snap install zoom-client
sudo snap install pycharm-professional --classic
sudo snap install aws-cli --classic

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc

brew install mkcert

# aws
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc
aws configure

# shortcuts
echo 'alias upgrade="sudo apt update && sudo apt dist-upgrade && sudo apt autoremove && sudo snap refresh && brew update && brew upgrade"' >> ~/.zshrc
