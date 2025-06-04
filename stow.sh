#!/bin/bash

cd $HOME/dotfiles/
stow . --adopt
git restore .
