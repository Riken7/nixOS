#!/usr/bin/env bash
pkill polybar

# Launch Polybar
polybar --config=$HOME/.dotfiles/config/i3/polybar/config.ini example & 
