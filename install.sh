LOCAL_BIN="$HOME/.local/bin"
PWD=$(pwd)

echo "Installing custom scripts and executables into ~/.local/bin"
mkdir -p "$LOCAL_BIN"
for file in bin/*; do
	ln -s "$PWD/$file" "$LOCAL_BIN/$(basename "$file")"
done


echo "Linking dotfiles to home"
DOTFILES="
	.bash_aliases
	.gitconfig
	.gitignore
	.muttrc
	.tmux.conf
	.vimrc
"
for file in $DOTFILES; do
	ln -s "$PWD/$file" "$HOME/$file"
done
