{ config, pkgs, lib,  ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # NVIDIA
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.modesetting.enable = true;
  programs.xwayland.enable = true;

  #################################### Disks #######################################
  ##################################################################################

  #ntfs
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/500G-ssd" =
    { device = "/dev/sdb2";
      fsType = "ntfs3"; 
      options = [ "rw" "uid=1000" "gid=100" "umask=0022" "fmask=0022" ];
    };

  #ext3
  fileSystems."/mnt/1TB-hdd" =
    { device = "/dev/sda1";
      fsType = "auto"; 
      options = ["defaults" "rw" ];
    };
  

  ############################### Nix configuration ################################
  ##################################################################################

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Overlay Packages
  # nixpkgs.overlays = [ (import ./packages) ];

 

  ################################# User Settings ###################################
  ###################################################################################


  # User
   users.users.halfarne = {
    isNormalUser = true;
    description = "halfarne";
    extraGroups = [ "networkmanager" "wheel" "audio" "disk" "video"];
    packages = with pkgs; [];
  };

  # Doas
  # Enable doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  # Configure doas
  security.doas.extraRules = [{
        users = [ "halfarne" ];
        keepEnv = true;
  }];


  # SSID
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Hostname
  networking.hostName = "halfofpc"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "cs_CZ.UTF-8";
  # console = {
  #   font = "Monocraft";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  console.keyMap = "cz-lat2";


  ##################################### Packages ######################################
  #####################################################################################

  environment.systemPackages = with pkgs; [ 
    
     gh
     git
     gcc

     ncurses

     python3

     rustc
     cargo
     jdk
     jre

     ranger
     btop
     starship
     tty-clock
     neofetch
     wget
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
     tor-browser-bundle-bin

     monocraft

     neovim
     grim
     slurp

     pipewire
     wireplumber
     pavucontrol
     pamixer
 
     blueman

     spotifyd
     spotify-tui

     papirus-icon-theme
     bibata-cursors
  ];

  ##################################### Programs and Services ######################################
  ##################################################################################################

  # Fonts
  fonts.fonts = with pkgs; [
   (nerdfonts.override { fonts = [ "Mononoki" ]; })
  ];

  # Blueman
  services.blueman.enable = true;

  xdg.portal.enable = true;

  # Java
  programs.java.enable = true;

  # Steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  # Starship
  programs.starship.enable = true;
  programs.starship.settings = {
  add_newline = false;
     format = "$directory$character";
     directory = {
       read_only = " ";
       truncation_length = 0;
     };
     character = {
       success_symbol = "[->](red bold)";
       error_symbol = "[->](red bold)";
     };
  };

  # NetworkManager
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Touchpad support
  services.xserver.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Pipewore
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = true;
   # If you want to use JACK applications, uncomment this
   #jack.enable = true;
  };

  ##################################### Enviroment Variables ######################################
  #################################################################################################

  environment.loginShellInit = ''
  
  export EGL_PLATFORM=wayland

  export _JAVA_AWT_WM_NONREPARENTING=1
  export XCURSOR_SIZE=24

  export LIBVA_DRIVER_NAME=nvidia
  export XDG_SESSION_TYPE=wayland
  export GMB_BACKEND=nvidia-drm
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export WLR_NO_HARDWARE_CURSORS=1
 
  export GDK_BACKEND=wayland

# export MOZ_DISABLE_RDD_SANDBOX=1
# export MOZ_ENABLE_WAYLAND=1

  export NVD_BACKEND=egl
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

