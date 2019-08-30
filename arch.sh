#!/usr/bin/env bash

set -e
set -o xtrace

sudo pacman -Syu
sudo pacman -S linux-headers
sudo pacman -S base-devel htop nmap cmake

# graphics
sudo mhwd -a pci nonfree 0300

# git
sudo pacman -S git
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.gitconfig > ~/.gitconfig

# yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd .. && rm -rf yay

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

# GDB
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.gdbinit > ~/.gdbinit

# python
sudo pacman -S python-pip
echo 'export PATH="/home/karol/.local/bin:$PATH"' >> ~/.zshrc
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
yay -S google-chrome slack-desktop sublime-text spotify ngrok jetbrains-toolbox

# brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc

# aws
pip3 install --user awscli
aws configure

# IDEs
echo "Download JetBrains toolbox:"
echo "https://www.jetbrains.com/toolbox/app/"
