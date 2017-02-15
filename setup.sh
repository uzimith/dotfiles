#!/bin/bash

# dotfiles
DOT_FILES=(.config .hammerspoon .tmux.conf .tmuxinator .gitconfig .gitignore_global .ssh bin .tigrc .vimperatorrc .vimperator .pryrc .eslintrc.json)

for file in ${DOT_FILES[@]}
do
    rm $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

brew tap Homebrew/bundle
brew bundle
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman
fisher
pip install git+git://github.com/powerline/powerline
pip install neovim
pip3 install neovim
