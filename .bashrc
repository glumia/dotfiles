# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
# HISTFILESIZE=10000  # if not specified it's the same as HISTSIZE

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -x /opt/homebrew/bin/lesspipe.sh ] && export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"

# set prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|xterm-kitty) color_prompt=yes;;
esac
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt

# Load aliases
[ -s ~/.bash_aliases ] && . ~/.bash_aliases
[ -s ~/.bash_private ] && . ~/.bash_private

# Load completion
[ -s /usr/share/bash-completion/bash_completion ] && \
    . /usr/share/bash-completion/bash_completion
[ -s /opt/homebrew/etc/profile.d/bash_completion.sh ] && \
	. /opt/homebrew/etc/profile.d/bash_completion.sh

# Load FZF keybindings and completion
[ -s /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -s /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -s /opt/homebrew/opt/fzf/shell/key-bindings.bash ] && \
	. /opt/homebrew/opt/fzf/shell/key-bindings.bash
[ -s /opt/homebrew/opt/fzf/shell/completion.bash ] && \
	. /opt/homebrew/opt/fzf/shell/completion.bash

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Brew
[ -s /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Fix for 'gpg: signing failed: Inappropriate ioctl for device'
export GPG_TTY=$(tty)

# Set colors for ls, fd and other CLI tools.
if command -v vivid 1>/dev/null; then
	LS_COLORS="$(vivid generate gruvbox-light-hard)"
	export LS_COLORS
fi

# Pyenv -- Keep this at the end of this file
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
