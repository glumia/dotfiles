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
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# My stuff
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Source .bashrc
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	# shellcheck disable=SC1090
	. "$HOME/.bashrc"
    fi
fi

### Platform specific stuff
case "$(uname -s)" in
	"Darwin")
		export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"
		;;
	"Linux")
		;;
	"OpenBSD")
		;;
esac

# Further Pyenv Stuff
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
