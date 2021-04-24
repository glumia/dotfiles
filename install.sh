LOCAL_BIN="$HOME/.local/bin"
PWD=$(pwd)

printf "Installing custom scripts and executables into ~/.local/bin\n"
mkdir -p "$LOCAL_BIN"
for file in bin/*; do
	printf "\tlinking ~/.local/$file to ./$file\n"
	ln -sf "$PWD/$file" "$LOCAL_BIN/$(basename "$file")"
done


printf "\nLinking home dotfiles\n"
DOTFILES="
	.bash_aliases
	.gitconfig
	.gitignore
	.muttrc
	.tmux.conf
	.vimrc
"
for file in $DOTFILES; do
	printf "\tlinking ~/$file to ./$file\n"
	ln -sf "$PWD/$file" "$HOME/$file"
done

printf "\nLinking configs\n"
CONFIGS="
	nvim
"
for config in $CONFIGS; do
	printf "\tlinking ~/.config/$config to ./.config/$config\n"
	ln -sf "$PWD/.config/$config" "$HOME/.config/$config"
done