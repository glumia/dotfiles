# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
export EDITOR=nvim
export BAT_THEME="gruvbox-light"
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude node_modules'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Go stuff
export PATH="$PATH:$HOME/.go/bin:$HOME/go/bin"
export GOPRIVATE="github.com/bcmi-labs*"

# Pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Node version manager stuff
export NVM_DIR="$HOME/.nvm"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

### Platform specific stuff
case "$(uname -s)" in
	"Darwin")
		export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"
		;;
	"Linux")
		# Docker (rootless install) stuff
		export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
		;;
	"OpenBSD")
		;;
esac

# Further Pyenv Stuff
eval "$(pyenv init --path)"
