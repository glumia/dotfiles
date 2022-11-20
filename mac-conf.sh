#!/bin/sh

echo "Configure key repeat"
defaults write -g InitialKeyRepeat -int 15  # 225 ms
defaults write -g KeyRepeat -int 1  # 15 ms

echo "Add tmux-256color terminal info"
brew install ncurses
/opt/homebrew/opt/ncurses/bin/infocmp -x tmux-256color > tmux-256color.src
tic -x tmux-256color.src
