#!/usr/bin/env bash
# Simple fastfetch wrapper with random logo selection

# Configuration directory
confDir="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/logo"

# Find and select a random logo image
random_logo=$(find -L "$confDir" -maxdepth 1 -type f \
    \( -name "wall.quad" -o -name "wall.sqre" -o -name "*.webp" \
    -o -name "*.icon" -o -name "*.jpeg" -o -name "*logo*" \
    -o -name "*.png" \) \
    ! -path "*/wall.set*" ! -path "*/wallpapers/*.png" 2>/dev/null | shuf -n 1)

# Display with fastfetch
clear
if [ -n "$random_logo" ]; then
    exec fastfetch --logo "$random_logo"
else
    # Fallback to kitty logo if no images found
    exec fastfetch --logo-type kitty
fi