#!/bin/sh
LOCAL_BIN="$HOME/.local/bin"
PWD=$(pwd)

printf "Installing custom scripts and executables into ~/.local/bin\n"
mkdir -p "$LOCAL_BIN"
for file in bin/*; do
	printf "\tlinking ~/.local/%s to ./%s\n" "$file" "$file"
	ln -sf "$PWD/$file" "$LOCAL_BIN/$(basename "$file")"
done


printf "\nLinking home dotfiles\n"
DOTFILES="
	.profile
	.bashrc
	.bash_aliases
	.gitconfig
	.gitignore
	.muttrc
	.tmux.conf
"
for file in $DOTFILES; do
	printf "\tlinking ~/%s to ./%s\n" "$file" "$file"
	ln -sf "$PWD/$file" "$HOME/$file"
done

printf "\nLinking configs\n"
CONFIGS="
	nvim
	kitty
	alacritty
	pycodestyle
"
mkdir -p ~/.config
for config in $CONFIGS; do
	printf "\tlinking ~/.config/%s to ./.config/%s\n" "$config" "$config"
	rm -rf "$HOME/.config/$config" # The ln -n option is not available on BSD systems
	ln -s "$PWD/.config/$config" "$HOME/.config/$config"
done

printf "\nInstalling neovim plugin manager\n"
plugpath="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
printf "\t%s\n" "$plugpath"
curl -sfLo "$plugpath" \
	--create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
