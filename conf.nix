{ config, pkgs, lib,  ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      #./hardware-configuration.nix #(in /etc/nixos/configuration.nix)
    ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  #boot.loader.grub.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # NVIDIA
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.modesetting.enable = true;
  programs.xwayland.enable = true;

  ############################### Linux Zen kernel #################################
  ##################################################################################

  boot.kernelPackages = pkgs.linuxPackages_zen;

  #################################### Disks #######################################
  ##################################################################################

  #ntfs
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/500G-ssd" =
    { device = "/dev/disk/by-uuid/57A11A4670A755AC";
      fsType = "ntfs3"; 
      options = [ "rw" "uid=1000" "gid=100" "umask=0022" "fmask=0022" ];
    };

  #ext3
  fileSystems."/mnt/1TB-hdd" =
    { device = "/dev/disk/by-uuid/29788cf6-33b0-45a7-8ee0-a5368cb4e723";
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
    extraGroups = [ "networkmanager" "wheel" "audio" "disk" "video" "input" "dialout"];
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
  	   persist = true;
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

     jdk
     jre

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

     rofi-wayland
     firefox-wayland
#     tor-browser-bundle-bin

     monocraft

     neovim
     grim
     slurp

     pavucontrol
     pamixer
 
     blueman

     spotifyd
     spotify-tui
  ];

  ############################################# Nix-ld #############################################
  ##################################################################################################
 
  programs.nix-ld.enable = true;

  #programs.nix-ld.package = pkgs.callPackage ../nix-ld.nix {};

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
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
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

  # Pulseaudio
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

#--not working:
  # Pipewore
#  hardware.pulseaudio.enable = false;
#  security.rtkit.enable = true;
#  services.pipewire = {
#   enable = true;
#   alsa.enable = true;
#   alsa.support32Bit = true;
#   pulse.enable = true;
#  };

  # Spotifyd
  #services.spotifyd.enable = true;
  #services.spotifyd.settings = {
  #global = {
  #  username = " Nothing to ";
  #  password = "  See Here  ";
  #  backend = "alsa";
  #  device_name = "moje_reproduktory";
  #  #bitrate = 160;
  #  #no_audio_cache = true;
  #  initial_volume = "100";
  #  #normalisation_pregain = -10;
  #  autoplay = true;
  #  device_type = "computer";
  #  };
  #};


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = config.system.nixos.22.11; # Did you read the comment?

}

