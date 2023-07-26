!/usr/bin/env bash

ln=0
cp=0

echo "Be sure to be in .dotfiles directory and don't forget to change home folder ;)."

read -p "Press enter to continue"

read -p "Link FIles? (Y/N): " confirm && [[ $confirmln == [yY] || $confirmln == [yY][eE][sS] ]] || echo Proceeding to copying files ...

if [[ $confirmln == [yY] ]]
  then

    ln -s /home/halfarne/.dotfiles/.config/hypr/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/dunst/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/kitty/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/gtk-3.0/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/plocha/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/spotifyd/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/spotify-tui/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/zathura/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/nvim/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/rofi/ /home/halfarne/.config/
    ln -s /home/halfarne/.dotfiles/.config/autostart.sh /home/halfarne/.config/

    ln -s /home/halfarne/.dotfiles/.themes/ /home/halfarne/

    ln -s /home/halfarne/.dotfiles/.bashrc /home/halfarne/
    ln -s /home/halfarne/.dotfiles/.bash_profile /home/halfarne/

    ln -s /home/halfarne/.dotfiles/.hyprinitrc /home/halfarne/
    ln -s /home/halfarne/.dotfiles/.dwlinitrc /home/halfarne/
  fi

read -p "Copy Files?(Y/N): " confirm && [[ $confirmcp == [yY] || $confirmcp == [yY][eE][sS] ]]

if [[ $confitmcp == [yY] ]]
  then

    cp /home/halfarne/.dotfiles/.config/hypr/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/dunst/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/kitty/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/gtk-3.0/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/plocha/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/spotifyd/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/spotify-tui/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/zathura/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/nvim/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/rofi/ /home/halfarne/.config/
    cp /home/halfarne/.dotfiles/.config/autostart.sh /home/halfarne/.config/

    cp /home/halfarne/.dotfiles/.themes/ /home/halfarne/

    cp /home/halfarne/.dotfiles/.bashrc /home/halfarne/
    cp /home/halfarne/.dotfiles/.bash_profile /home/halfarne/

    cp /home/halfarne/.dotfiles/.hyprinitrc /home/halfarne/
    cp /home/halfarne/.dotfiles/.dwlinitrc /home/halfarne/
  fi

if [[ $confirmln != [yY] && $confirmcp != [yY] ]]
  then

    echo No option selected
  fi

read -p "Clone and build DWL (only for NixOs or with installed Nix)(Y/N): " confirm && [[ $confirmdwl == [yY] || $confirmdwk == [yY][eE][sS] ]]

if [[ $confitmcp == [yY] ]]
  then

    cd ~
    git clone https://github.com/Halfarne/dwl.git
    cd dwl

    nix build
  fi

read -p "Exiting program..." && exit 1
