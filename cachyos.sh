#!/usr/bin/env bash

set -ex

# wifi country
sudo micro /etc/conf.d/wireless-regdom

sudo pacman -Syu
sudo pacman -S git python-argcomplete flatpak brave-bin tree
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.zshrc > ~/.zshrc

# gaming
sudo pacman -S cachyos-gaming-meta
sudo pacman -S cachyos-gaming-applications

# firmware
fwupdmgr get-updates
fwupdmgr update
