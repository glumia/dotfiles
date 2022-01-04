### Editor shortcut
alias v="nvim"

### Enable aliases with sudo
alias sudo="sudo "

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
alias glg="git log --all --decorate --oneline --graph"
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

### Change directory to root path of git repository
alias c='cd $(git rev-parse --show-toplevel)'

### Some ls shortcuts
alias l="ls -lhF" # ls with better defaults
alias la="ls -a"
alias ll="ls -la"

### Docker compose shortcus
alias dc="docker-compose"
alias dcu="docker-compose up"

### Git config for work repositories
alias git-config-arduino="git config user.signingkey 2B581A92B13543C26099E11893DE8D68B831B86F && git config user.email g.lumia@arduino.cc"
alias git-config-gorgias="git config user.signingkey B9055507161F10604D1239DF4491F7094749A6E6 && git config user.email giuseppe.lumia@gorgias.com"

### Use local version of serverless framework
alias sls="./node_modules/.bin/sls"

### Platform specific aliases
case "$(uname -s)" in
	"Darwin")
		;;
	"Linux")
		alias pbcopy="xclip -selection clipboard"
		alias pbpaste="xclip -selection clipboard -o"
		;;
	"OpenBSD")
		alias pbcopy="xclip -selection clipboard"
		alias pbpaste="xclip -selection clipboard -o"
		alias feh="feh --conversion-timeout 1"
		;;
esac

### Enable/disable microphone loopback (linux only)
alias miclb="pactl load-module module-loopback latency_msec=1"
alias unmiclb="pactl unload-module module-loopback"

### Utilities

# gocover runs tests of go module(s) passed as argument and opens their coverage report
# on browser.
gocover(){
	local t
	t=$(mktemp -t cover.XXXXXX)
	go test -coverprofile="$t" "$@" && go tool cover -html "$t" && rm "$t"
}
