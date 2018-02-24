#!/bin/bash

sudo apt-get update

sudo apt-get install -y git wget nano htop

sudo apt-get install -y dropbox atom firefox slack spotify sublime-text

sudo apt-get install -y zsh terminator

bash <(curl -s https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/common.sh)

sudo apt-get install python3 nvm
sudo pip install virtualenv
