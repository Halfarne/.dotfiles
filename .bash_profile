#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ "$(tty)" == "/dev/tty1" ]]
 then
    echo "1) - MagmaWM"
    echo "2) - DWL - Default"
    echo "3) - Hyprland - Default v tty2"
    # moznost="USER INPUT"
    read -p "Moznost:" moznost
    if [ "$moznost" -eq "1" ] || [ "$moznost" -eq "2" ] || [ "$moznost" -eq "3" ];
        then
            if [ "$moznost" -eq "1" ];
                then
                    ./.magmainitrc
                fi
            if [ "$moznost" -eq "2" ];
                then
                    ./.dwlinitrc
                fi
            if [ "$moznost" -eq "3" ];
                then
                    ./.hyprinitrc
                fi
        else #default
            ./.dwlinitrc
        fi
  fi
[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ "$(tty)" == "/dev/tty2" ]]
 then
  ./.hyprinitrc
fi
