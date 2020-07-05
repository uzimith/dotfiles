#!/bin/bash

# dotfiles
DOT_FILES=(.config .tmux.conf .ssh bin .tigrc)

ln -s $HOME/dotfiles/$file $HOME/$file

for file in ${DOT_FILES[@]}
do
    rm $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

chmod ~/.ssh/* 600
git clone git://github.com/powerline/powerline
pip install git+git://github.com/powerline/powerline
pip install neovim
