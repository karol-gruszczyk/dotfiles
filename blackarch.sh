#!/usr/bin/env bash

set -e
set -o xtrace

# BlackArch keyring
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
rm strap.sh

# cracking
sudo pacman -S aircrack-ng cowpatty
