#!/bin/bash

curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.zshrc > ~/.zshrc
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.aliases > ~/.aliases

mkdir ~/.ssh
curl https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/.ssh/config > ~/.ssh/config

git config --global user.email "karol.gruszczyk@gmail.com"
git config --global user.name "karol-gruszczyk"
git config --global core.editor "subl --wait"

git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
