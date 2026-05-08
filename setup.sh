#!/bin/bash

# dotfiles
DOT_FILES=(.config .tmux.conf bin .tigrc)

ln -s $HOME/dotfiles/$file $HOME/$file

for file in ${DOT_FILES[@]}
do
    rm $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

chmod ~/.ssh/* 600
