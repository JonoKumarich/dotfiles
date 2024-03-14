#!/bin/bash

cd /Users/jkumarich/.config || exit
rm -f Brewfile
brew bundle dump
git add Brewfile

