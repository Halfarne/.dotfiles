#!/bin/bash

R=$(shuf -i 1-6 -n 1)

if [ $R -eq 1 ]; then
	hyprpaper --config ~/.config/plocha/plocha1.conf
fi

if [ $R -eq 2 ]; then
	hyprpaper --config ~/.config/plocha/plocha2.conf
fi

if [ $R -eq 3 ]; then
	hyprpaper --config ~/.config/plocha/plocha3.conf
fi

if [ $R -eq 4 ]; then
	hyprpaper --config ~/.config/plocha/plocha4.conf
fi

if [ $R -eq 5 ]; then
        hyprpaper --config ~/.config/plocha/plocha5.conf
fi

if [ $R -eq 6 ]; then
        hyprpaper --config ~/.config/plocha/plocha6.conf
fi
