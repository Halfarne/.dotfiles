{ config, pkgs, ... }:

{

# Packages
environment.systemPackages = with pkgs; [ 
    
     gh
     git
     gcc
     rustc
     cargo
     jdk
     jre

     ranger
     btop
     starship
     tty-clock
     wget
     vlc
     kitty

     lutris
     steam
     dxvk
     wineWowPackages.stable
     winetricks

     nvidia-vaapi-driver
     libva
     libinput

     hyprpaper

     discord
     rofi-wayland
     firefox-wayland
#     xfce.thunar
     tor-browser-bundle-bin

     monocraft

     neovim
#     micro

     grim
     slurp

     pipewire
     wireplumber
     pavucontrol
 
     blueman
 ];

 # Fonts
 fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "Mononoki" ]; })
 ];

 # Blueman
 services.blueman.enable = true; 

 xdg.portal.enable = true;
# xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

 # Non-free
 nixpkgs.config.allowUnfree = true;

 # Java
 #programs.java.enable = true;

 # Steam
 programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
 };


 # Starship
 programs.starship.enable = true;


}
