#!/bin/bash

cd $HOME/dotfiles/
stow . --adopt --no-folding
git restore .
