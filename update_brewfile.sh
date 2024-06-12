#!/bin/bash

cd $HOME/.config || exit
rm -f Brewfile
brew bundle dump
git add Brewfile

