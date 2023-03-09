#!/usr/bin/env bash

cd ~ 

R=$(shuf -i 1-6 -n 1)

if [ $R -eq 1 ]; then
	hyprpaper --config ~/.config/plocha/plocha1.conf
	#wal -i .config/plocha/plocha1.png
fi

if [ $R -eq 2 ]; then
	hyprpaper --config ~/.config/plocha/plocha2.conf
	#wal -i .config/plocha/plocha2.jpg
fi

if [ $R -eq 3 ]; then
	hyprpaper --config ~/.config/plocha/plocha3.conf
	#wal -i .config/plocha/plocha3.jpg
fi

if [ $R -eq 4 ]; then
	hyprpaper --config ~/.config/plocha/plocha4.conf
	#wal -i .config/plocha/plocha4.jpg
fi

if [ $R -eq 5 ]; then
        hyprpaper --config ~/.config/plocha/plocha5.conf
	#wal -i .config/plocha/plocha5.jpg
fi

if [ $R -eq 6 ]; then
        hyprpaper --config ~/.config/plocha/plocha6.conf
	#wal -i .config/plocha/plocha6.jpg
fi
