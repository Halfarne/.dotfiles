{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./services.nix
      ./pipewire.nix
      ./envir.nix
    ];

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # NVIDIA
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.modesetting.enable = true;
  programs.xwayland.enable = true;

  # Disks
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
  

  # Nix configuration
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

  # Hostname
  networking.hostName = "halfofpc"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "cs_CZ.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  console.keyMap = "cz-lat2";


  # Configure keymap in X11
  services.xserver.layout = "cz";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

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


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
