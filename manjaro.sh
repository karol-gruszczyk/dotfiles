#!/usr/bin/env bash

set -e
set -o xtrace

# enable deep suspend
sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT/# &/' /etc/default/grub
NEW_GRUB_CMDLINE='GRUB_CMDLINE_LINUX_DEFAULT="mem_sleep_default=deep"'
sudo sed -i "0,/# GRUB_CMDLINE_LINUX_DEFAULT/s/# GRUB_CMDLINE_LINUX_DEFAULT/${NEW_GRUB_CMDLINE}\n&/" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# setup
sudo pacman-mirrors --geoip
sudo pacman -Syyu
sudo pacman -S linux-headers
sudo pacman -S base-devel htop nmap cmake jq

# git
cp .gitconfig ~

# yay
git clone https://aur.archlinux.org/yay.git
cd yay
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
cp .config/terminator/* ~/.config/terminator/

# fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# zsh
sudo pacman -S zsh
rm -rf ~/.oh-my-zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp .zshrc ~

# GDB
cp .gdbinit ~

# python
sudo pacman -S python-pip
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
pip install --user virtualenv

# npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node
echo '
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> ~/.zshrc

# docker
sudo pacman -S docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ${USER}

# misc
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45
yay -S google-chrome slack-desktop sublime-text spotify ngrok jetbrains-toolbox

# aws
pip3 install --user awscli
aws configure

# startup
cp .config/autostart/* ~/.config/autostart/

