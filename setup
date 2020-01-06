#!/bin/bash

set -o xtrace
set -e

link_in_homedir=( vimrc zshrc hyper.js tmux.conf gitignore_global hammerspoon )
link_in_config=( fish nvim )

for i in "${link_in_homedir[@]}"
do
	ln -nsf "$HOME/.dotfiles/$i" "$HOME/.$i"
done

mkdir -p ~/.config
for i in "${link_in_config[@]}"
do
	ln -nsf "$HOME/.dotfiles/$i" "$HOME/.config/$i"
done

git config --global core.excludesfile ~/.gitignore_global 
