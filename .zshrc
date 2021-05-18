# Configure completions
autoload -Uz compinit
compinit

# Source aliases
source "$HOME/.bash_aliases"

# Add custom binaries to path
export PATH="$HOME/.local/bin:$PATH"

# Fix for 'gpg: signing failed: Inappropriate ioctl for device'
export GPG_TTY=$(tty)

# Move by word with Alt(Option)+Arrow
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
