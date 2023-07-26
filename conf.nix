{ pkgs, lib,  ... }:

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

  boot.kernelParams = ["msr.allow_writes=on"];

  #################################### Disks #######################################
  ##################################################################################

  #ntfs
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/500G-ssd" =
    { device = "/dev/disk/by-uuid/57A11A4670A755AC";
      fsType = "ntfs"; 
      options = [ "rw" "uid=1001" "gid=100" "umask=0022" "fmask=0022" ];
    };

  #ext3
  fileSystems."/mnt/1TB-hdd" =
    { device = "/dev/disk/by-uuid/29788cf6-33b0-45a7-8ee0-a5368cb4e723";
      fsType = "ext3"; 
      options = ["defaults" "rw"];
    };

   # ...
   #fileSystems."/nix" = {
   #  device = "/dev/disk/by-uuid/019e842a-5d1b-4836-8170-d67230765e9b";
   #  fsType = "btrfs";
   #  neededForBoot = true;
   #  options = [ "noatime" ];
   #};
 

  

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

  environment.shellAliases = {
      please = "doas";
      sudo = "doas";
      nreb = "nixos-rebuild switch --flake /etc/nixos#halfofpc";
  };

  programs.dconf.enable = true;

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

  # Pam_USB
  #security.pam.usb.enable = true;


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
   console = {
     font = "monocraft";
     keyMap = "cz-lat2";
   };

   services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0666"
    '';


  #console.keyMap = "cz-lat2";

  ##################################### /etc/issue ####################################
  #####################################################################################
  environment.etc = {
  # Creates /etc/issue
  issue = {
      text = ''
   _  ___      ____  ____
  / |/ (_)_ __/ __ \/ __/
 /    / /\ \ / /_/ /\ \  
/_/|_/_//_\_\\____/___/  (this is \l)

       '';

      # The UNIX file mode bits
      mode = "0440";
    };
  };
  ##################################### Packages ######################################
  #####################################################################################

  environment.systemPackages = with pkgs; [

     gh
     git
     gcc

     jdk17
     #jre

     python3

     btop
     starship
     wget
     kitty
     dunst
     #gparted
     nitch
     zip
     unzip
     bashmount
     exfatprogs

     #minicom
     #libusb1
     #openocd
     #cmake
     #gcc-arm-embedded
     #pico-sdk
     #picotool

     rshell

     lutris
     steam
     steamtinkerlaunch
     prismlauncher
     dxvk
     wineWowPackages.stable
     winetricks
     #gamescope
     mangohud

     obsidian

     nvidia-vaapi-driver
     libva
     libinput

     hyprpaper
     wl-clipboard

     rofi-wayland
     firefox-wayland
#     tor-browser-bundle-bin

     monocraft

     neovim
     grim
     slurp

     #pavucontrol
     pamixer
     pulsemixer

     mpv
     #mpc-cli
     pms

     onlyoffice-bin
     zathura

     jmtpfs
     mtpfs

     freecad
     eagle
     prusa-slicer
 
     blueman
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

  #XDG
  xdg.portal.enable = true;

  # KDEconnect
  programs.kdeconnect.enable = true;
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };

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
     format = "$nix_shell$directory$character";
     directory = {
       read_only = " :x";
       truncation_length = 0;
       style = "bold cyan";
     };
     character = {
       success_symbol = "[>](white bold)";
       error_symbol = "[>](red bold)";
     };
     nix_shell = {
       symbol = "❄(boldw white) ";
       style = "bold blue";
       format = "[$symbol$state( \($name\))]($style) ";
     };
  };

  # Gamescope
  #programs.gamescope.enable=true;

  #nixpkgs.config.packageOverrides = pkgs: {
  #  steam = pkgs.steam.override {
  #    extraPkgs = pkgs: with pkgs; [
  #      xorg.libXcursor
  #      xorg.libXi
  #      xorg.libXinerama
  #      xorg.libXScrnSaver
  #      libpng
  #      libpulseaudio
  #      libvorbis
  #      stdenv.cc.cc.lib
  #      libkrb5
  #      keyutils
  #    ];
  #  };
  #};

  # NetworkManager
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #udisk
  services.udisks2.enable=true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  #Pulseaudio
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;
  #hardware.pulseaudio.support32Bit = true;

  services.mpd = {
   enable = true;
   musicDirectory = "/mnt/1TB-hdd/Hudba";
   user = "halfarne";
   extraConfig = ''
      audio_output {
      type "pipewire"
      name "Pipewire"
      }
   '';
   network.listenAddress = "any"; 
   startWhenNeeded = true; 
  };
  systemd.services.mpd.environment = {
   # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
   # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
   XDG_RUNTIME_DIR = "/run/user/1001";
  };

  
  #Syncthing
  services = {
    syncthing = {
        enable = true;
        user = "halfarne";
        dataDir = "/mnt/1TB-hdd/Syncthing";    # Default folder for new synced folders
        configDir = "/mnt/1TB-hdd/Syncthing/.config";   # Folder for Syncthing's settings and keys
    };
  };

  services.syncthing.extraOptions.gui = {
    user = "halfarne";
    password = "halfarne";
  };

#--not working:
  # Pipewore
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = true;
   jack.enable = true;
   wireplumber.enable = true;
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = config.system.nixos.22.11; # Did you read the comment?

}

