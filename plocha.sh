#!/usr/bin/env bash

FILE=$(find ~/.config/plocha -type f | shuf --random-source=/dev/urandom -n 1)

echo $FILE
echo -ne "preload = $FILE \nwallpaper = DP-1,$FILE" > ~/.config/plocha.conf

hyprpaper --config ~/.config/plocha.conf 
