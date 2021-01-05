# glumia
# -----------------------------------------------------------------------------

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set prompt style
PS1='\u@\h:\w\$ '

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

### Platform specific aliases/settings
case $(uname -s) in
	"Darwin")
		alias vim="/usr/local/Cellar/vim/8.2.1950/bin/vim"
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
