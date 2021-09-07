#!/usr/bin/env bash

set -e
set -o xtrace

# setup
sudo pacman-mirrors --geoip
sudo pacman -Syyu
sudo pacman -S linux-headers
sudo pacman -S base-devel htop nmap cmake jq

# git
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.gitconfig > ~/.gitconfig

# yay
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd .. && rm -rf yay

# graphics https://wiki.archlinux.org/index.php/Dell_XPS_15_9570#Graphics
sudo mhwd -a pci nonfree 0300
sudo pacman -S bumblebee
sudo usermod -a -G bumblebee ${USER}
sudo pacman -S nvidia
sudo pacman -S powertop

# terminator
sudo pacman -S terminator
mkdir -p ~/.config/terminator
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.config/terminator/config > ~/.config/terminator/config

# fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# zsh
sudo pacman -S zsh
rm -rf ~/.oh-my-zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.zshrc > ~/.zshrc

# python
sudo pacman -S python-pip
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
pip install --user virtualenv
pip install argcomplete

# docker
sudo pacman -S docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ${USER}

# misc
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45
yay -S google-chrome slack-desktop zoom sublime-text ngrok jetbrains-toolbox spotify

# aws
pip install awscli
aws configure

# startup
cp .config/autostart/* ~/.config/autostart/

