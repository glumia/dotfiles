# Configure completions
autoload -Uz compinit
compinit

# Source aliases
source /Users/gius/.bash_aliases

# Fix for 'gpg: signing failed: Inappropriate ioctl for device'
export GPG_TTY=$(tty)

# Move by word with Alt(Option)+Arrow
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
