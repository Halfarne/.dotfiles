#!/usr/bin/env bash

cd ~

cp ~/.dotfiles/{autostart.sh, gtk-3.0, neofetch, spotifyd, hypr, nvim, spotify-tui, ranger, dunst, kitty, plocha, rofi} ~/.config/

#autostart.sh, gtk-3.0, neofetch, spotifyd, hypr, nvim, spotify-tui, ranger, dunst, kitty, plocha, rofi

if ! which doas > /dev/null; then
   echo -e "Doas not found! Install? (y/n) \c"
   read
   if "$REPLY" = "y"; then
	sudo pacman -Syu && sudo pacman -S opendoas
	sudo echo "permit persist :halfarne" > /etc/doas.conf
	doas pacman -Rs sudo
   fi
fi

doas pacman -Syu nvidia-open-dkms nvidia-utils wine xorg-xwayland dhcpd lutris steam firefox discord ttf-mononoki-nerd --needed base-devel

cd ~ && mkdir .gitrepos/ && cd .gitrepos

programs="dxvk-bin hyprland-nvidia-git hyprpaper-git nvidia-vaapi-driver-git onlyoffice-bin rofi-lbonn-wayland-git tty-clock-git otf-monocraft"

if ! which paru > /dev/null; then
   echo -e "Paru not found! Install? (y/n) \c"
   read
   if "$REPLY" = "y"; then
	   git clone https://github.com/Morganamilo/paru.git
	   cd paru && makepkg -si
   fi
fi

paru -S $programs
