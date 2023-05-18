#!/usr/bin/env bash

FILE=$(find ~/.config/plocha -type f | shuf --random-source=/dev/urandom -n 1)

echo $FILE
echo -ne "preload = $FILE \nwallpaper = DP-1,$FILE" > ~/.cache/plocha.conf

hyprpaper --config ~/.cache/plocha.conf

&&

exec dunst && 

exec "gsettings set org.gnome.desktop.interface gtk-theme 'Everforest-Dark-B'" &
#exec "gsettings set org.gnome.desktop.interface icon-theme 'ePapirus'" &
exec "gsettings set org.gnome.desktop.interface font-name 'mononoki Nerd Font 11'"

#exec "wal -t --theme .config/pywaltheme-new.json"
#wal -R
