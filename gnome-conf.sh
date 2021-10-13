#!/bin/sh
printf "Installing GNOME config\n"
walldir="/home/$USER/.local/share/backgrounds"
mkdir -p "$walldir"
cp wallpapers/anna-wangler-turtle-unsplash.jpg "$walldir"
dconf load / < dconf.txt
