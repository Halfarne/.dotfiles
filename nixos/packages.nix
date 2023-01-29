{ config, pkgs, ... }:

{

# Packages
environment.systemPackages = with pkgs; [ 
    
     gh
     git
     gcc
     rustc
     cargo
     jde
     jre

     ranger
     btop
     starship
     tty-clock
     wget
     vlc

     lutris
     steam
     dxvk
     wineWowPackages.stable
     winetricks

     nvidia-vaapi-driver
     libva
     libinput

     discord
     rofi-wayland
     firefox-wayland
#     xfce.thunar
     tor-browser-bundle-bin

     monocraft
     (nerdfonts.override { fonts = [ "Mononoki" ]; })

     neovim
#     micro

     grim
     slurp

     pipewire
     wireplumber
     pavucontrol
 
     blueman
];

 # Blueman
 services.blueman.enable = true; 

 xdg.portal.enable = true;
# xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

 # Non-free
 nixpkgs.config.allowUnfree = true;

 # Java
 #programs.java.enable = true;

 # Starship
 programs.starship.enable = true;


}
