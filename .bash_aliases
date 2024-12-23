### Editor shortcut
alias v="nvim"

### Enable aliases with sudo
alias sudo="sudo "

### Git shortcuts
alias g="git"
alias ga="git add"
alias gap="git add --patch --interactive"
alias gb="git branch"
alias gbp="git branch | fzf -m | tr -d ' *'" 
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
alias gcm='git checkout "$(basename "$(git rev-parse --abbrev-ref origin/HEAD)")"'
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
alias gmb='git merge-base "$(git rev-parse --abbrev-ref origin/HEAD)" HEAD'
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

### Configure auto-complete for the most used git aliases
__load_completion git # force bash-completion to load the git completion helpers
__git_complete gco _git_checkout
__git_complete gsh _git_show
__git_complete gd _git_diff
__git_complete gl _git_log
__git_complete grs _git_reset

### Change directory to root path of git repository
alias c='cd $(git rev-parse --show-toplevel)'

### Modern Unix
alias ls="ls --color=auto"
alias l="ls -lhF" # ls with better defaults
alias grep='grep --color=auto'
command -v bat > /dev/null && alias cat="bat -p"
if command -v kitty > /dev/null; then
	alias s="kitty +kitten ssh"
else
	alias s="ssh"
fi

### Docker compose shortcus
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"

### Terraform
alias tf="terraform"

### Git config for work repositories
# Hey you! Don't bother to report this to my company as a data leak, all my public GPG
# keys (and their emails) are already available at github.com/glumia.gpg (as those of
# any other Github user).
#
# Obfuscated to prevent it from ending up on search engines and getting spam.
#
# shellcheck disable=SC2139
alias git-config-gorgias="$(printf Z2l0IGNvbmZpZyB1c2VyLnNpZ25pbmdrZXkgQjkwNTU1MDcxNjFGMTA2MDREMTIzOURGNDQ5MUY3MDk0NzQ5QTZFNiAmJiBnaXQgY29uZmlnIHVzZXIuZW1haWwgZ2l1c2VwcGUubHVtaWFAZ29yZ2lhcy5jb20K | base64 --decode)" 

### Use local version of serverless framework
alias sls="./node_modules/.bin/sls"

### Tmux related
alias mux="tmuxinator"

### tools that don't play well with TERM=tmux-256color
alias k9s="TERM=xterm-256color k9s"
alias ngrok="TERM=xterm-256color ngrok"

### Platform specific aliases
case "$(uname -s)" in
	"Darwin")
		alias upgrade="brew update && brew upgrade && nvim +PlugUpdate +PlugUpgrade +CocUpdate +qa"
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

# xwfutojson reads x-www-form-urlencoded data from stdin and prints it to stdout
# as json.
xwfutojson(){
	python3 -c '
import json
from urllib.parse import parse_qsl

print(json.dumps(dict(parse_qsl(input(), keep_blank_values=True))))
' | jq
}
