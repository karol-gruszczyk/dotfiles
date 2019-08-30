#!/usr/bin/env bash

set -e
set -o xtrace

apt-get update
apt-get dist-upgrade


# zsh
sudo apt install -y zsh
rm -rf ~/.oh-my-zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.zshrc > ~/.zshrc

# setup SPI interface
echo "dtparam=spi=on" >> /boot/config.txt

# RDP
apt install xrdp
service xrdp start
service xrdp-sesman start
update-rc.d xrdp enable
