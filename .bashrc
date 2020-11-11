# Settings taken from Debian's default .bashrc
# -----------------------------------------------------------------------------
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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# -----------------------------------------------------------------------------

# glumia
# -----------------------------------------------------------------------------
## Aliases
### Editor shortcut
alias vi="vim"
alias v="vim"

### Git shortcuts
alias g="git"
alias ga="git add"
alias gap="git add --patch --interactive"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -D"
alias gbl="git blame -b -w"
alias gbs="git bisect"
alias gbsb="git bisect bad"
alias gbsg="git bisect good"
alias gbsr="git bisect reset"
alias gbss="git bisect start"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --no-edit --amend"
alias gcmsg="git commit -m"
alias gcl="git clone"
alias gcm="git checkout master"
alias gcd="git checkout develop"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gd="git diff"
alias gf="git fetch"
alias gfo="git fetch origin"
alias gl="git log"
alias gm="git merge"
alias gma="git merge --abort"
alias gp="git push"
alias grm="git rm"
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase -i"
alias grs="git reset"
alias grsh="git reset --hard"
alias gs="git status"
alias gst="git stash"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsh="git show"
alias gsu="git submodule update"
alias gts="git tag -s"
alias gpl="git pull"
alias gup="git pull --rebase"
alias gt="git tag -a"

### Some ls shortcuts
alias la="ls -a"
alias ll="ls -la"

### Docker compose shortcus
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcutest="docker-compose up pg mongodb redis elastic"

### Platform specific aliases
case $(uname -s) in
	"Darwin")
		alias vim="/usr/local/Cellar/vim/8.2.1900/bin/vim"
		alias ctags="/usr/local/Cellar/ctags/5.8_1/bin/ctags"
		;;
	"Linux")
		alias pycharm="/home/gius/pycharm-community-2020.2.2/bin/pycharm.sh 2>/dev/null & "
		;;
esac


## Bash hooks
### Activate Bash-Tiasft (aliases suggestions)
#[[ -f ~/bash-tiasft/bash-tiasft.sh ]] && source ~/bash-tiasft/bash-tiasft.sh

### Activate Bash-Preexec (pre-post command hooks)
#[[ -f ~/bash-preexec/bash-preexec.sh ]] && source ~/bash-preexec/bash-preexec.sh
