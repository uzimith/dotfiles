#!/bin/bash

# dotfiles
DOT_FILES=(.config .tmux.conf .ssh bin .tigrc .hammerspoon)

ln -s $HOME/dotfiles/$file $HOME/$file

for file in ${DOT_FILES[@]}
do
    rm $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

chmod ~/.ssh/* 600
