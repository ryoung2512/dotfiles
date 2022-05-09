#!/bin/sh

ln -sfv ~/dotfiles/.zshrc ~/.zshrc
ln -sfnv ~/dotfiles/.zsh ~/.zsh

ln -sfv ~/dotfiles/.pryrc ~/.pryrc

#preinstall zinit plugins
zsh -i -c -- '@zinit-scheduler burst'
