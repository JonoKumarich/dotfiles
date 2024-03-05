#!/bin/bash

# Navigate to the directory containing the Brewfile
cd /Users/jonathankumarich/.config || exit

# Remove the existing Brewfile
rm -f Brewfile

# Dump the current Brew setup into a new Brewfile
brew bundle dump

# Add the new Brewfile to git
git add Brewfile

