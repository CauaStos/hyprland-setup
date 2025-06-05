#!/bin/bash

cd $HOME/dotfiles/
stow . --adopt --no-folding --dotfiles
git restore .
