#!/usr/bin/env bash

exec ~/.config/plocha.sh &&

exec dunst && 

exec "gsettings set org.gnome.desktop.interface gtk-theme 'Everforest-Dark-B'" &
#exec "gsettings set org.gnome.desktop.interface icon-theme 'ePapirus'" &
exec "gsettings set org.gnome.desktop.interface font-name 'mononoki Nerd Font 11'" &&

#exec "wal -t --theme .config/pywaltheme-new.json"
#wal -R
