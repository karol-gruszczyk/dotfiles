#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git wget nano htop watch

brew cask install dropbox atom firefox slack spotify sublime-text ngrok

brew cask install iterm2
brew install zsh

bash <(curl -s https://raw.githubusercontent.com/karol-gruszczyk/dotfiles/master/common.sh)

brew install python3
pip3 install --upgrade pip setuptools wheel
