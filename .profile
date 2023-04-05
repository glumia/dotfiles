# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
export EDITOR=nvim
export BAT_THEME="gruvbox-light"
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude node_modules'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Go stuff
export PATH="$HOME/.go/bin:$HOME/go/bin:$PATH"

# Pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Node version manager stuff
export NVM_DIR="$HOME/.nvm"

# Rust stuff
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby stuff
if command -v ruby >/dev/null && command -v gem >/dev/null; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Docker stuff
export PATH="$HOME/.docker/bin:$PATH"

# My stuff
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

### Platform specific stuff
case "$(uname -s)" in
	"Darwin")
		export PATH="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH"
		export PATH="$HOME/Library/Python/3.9/bin:$PATH"
		[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
		;;
	"Linux")
		;;
	"OpenBSD")
		;;
esac

# Source .bashrc
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	# shellcheck disable=SC1090
	. "$HOME/.bashrc"
    fi
fi

# Further Pyenv Stuff
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
