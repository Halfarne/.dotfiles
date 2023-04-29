{ config, pkgs, lib,  ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      #./hardware-configuration.nix #(in /etc/nixos/configuration.nix)
    ];

  # Boot
  boot.loader.grub.device = "/dev/disk/by-id/ata-WDC_WD3200BEVT-22A23T0_WD-WX91A4030606";

  ############################### Linux Zen kernel #################################
  ##################################################################################

  boot.kernelPackages = pkgs.linuxPackages_5_4;

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
   users.users.adamstoctyricet = {
    isNormalUser = true;
    description = "adamstoctyricet";
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
        users = [ "adamstoctyricet" ];
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
  networking.hostName = "halfofserver"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "cs_CZ.UTF-8";
   console = {
     font = "monocraft";
     keyMap = "cz-lat2";
   };

  #console.keyMap = "cz-lat2";

  ##################################### /etc/issue ####################################
  #####################################################################################
  environment.etc = {
  # Creates /etc/nanorc
  issue = {
      text = ''
   _  ___      ____  ____
  / |/ (_)_ __/ __ \/ __/
 /    / /\ \ / /_/ /\ \  
/_/|_/_//_\_\\____/___/  (server)

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


     jdk
     jre

     python3

     btop
     starship
     wget
     nitch
     zip
     unzip
     bashmount
     exfatprogs
     tmux

     monocraft

     neovim

     pamixer

     blueman

     xmrig
  ];

  ##################################### Programs and Services ######################################
  ##################################################################################################

  # Fonts
  fonts.fonts = with pkgs; [
   (nerdfonts.override { fonts = [ "Mononoki" ]; })
  ];

  # Blueman
  services.blueman.enable = true;

  # Java
  programs.java.enable = true;

  # Starship
  programs.starship.enable = true;
  programs.starship.settings = {
  add_newline = false;
     format = "$nix_shell$directory$character";
     directory = {
       read_only = " ";
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

  # NetworkManager
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #udisk
  services.udisks2.enable=true;

  ##################################### Podman containers ##########################################
  ##################################################################################################

  #Home assistant
  #virtualisation.oci-containers = {
  #  backend = "podman";
  #  containers.homeassistant = {
  #    volumes = [ "home-assistant:/config" ];
  #    environment.TZ = "Europe/Prague";
  #    image = "ghcr.io/home-assistant/home-assistant:stable"; # Warning: if the tag does not change, the image will not be updated
  #    extraOptions = [ 
        #"--network=host" 
        #"--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
  #    ];
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

