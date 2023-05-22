#!/bin/sh
printf "Installing GNOME config\n"
dconf load / < dconf.txt
