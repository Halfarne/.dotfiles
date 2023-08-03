#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ "$(tty)" == "/dev/tty1" ]]
 then
  echo "1) - MagmaWM - Default"
  echo "2) - DWL"
  echo "3) - Hyprland - Default v tty2"
  # moznost="USER INPUT"
  read -p "Moznost: " moznost
  if [[moznost == "1" || moznost == "2" || moznost == "3"]]

    then
      if [[moznost == "1"]]
        then
          ./.magmainitrc
        fi
      if [[moznost == "2"]]
        then
          ./.dwlinitrc
        fi
      if [[moznost == "3"]]
        then
          ./.hyprinitrc
        fi

    else #default
      ./.magmainitrc

    fi
fi
[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ "$(tty)" == "/dev/tty2" ]]
 then
  ./.hyprinitrc
fi
