#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/forest"

# Terminate already running bar instances

# Wait until the processes have been shut down

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
