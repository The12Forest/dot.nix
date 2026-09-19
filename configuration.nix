{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./Custom/graphical.nix
      ./Custom/apps.nix
      ./Custom/app_config.nix
      ./Custom/users.nix
      ./Custom/file_system.nix
      ./Custom/remote.nix
      ./Custom/aliases.nix
      ./Custom/startup.nix
      ./Custom/printer.nix

      # Home Manager
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
        sha256 = "sha256:02mrnlirg3jxqfgkv3jh8ar9hqiwhwqq9m7n5jv5hq40vjzq2s1d"; 
      } + "/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/disk/by-uuid/fb602da5-4112-4387-aa4c-4a9c7db60fb0";

  networking.hostName = "ManuelPC";
  networking.nameservers = [ "10.10.2.9" "1.1.1.1" "8.8.8.8" ];
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.logind = {
    settings = {
      Login = {
        HandlePowerKey = "hibernate";
        PowerKeyIgnoreInhibited = "yes";
      };
    };
  };

  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/settings-daemon/plugins/power" = {
          power-button-action = "hibernate";
        };
      };
    }
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #nix.gc = {
  #  automatic = true;
  #  dates = "weekly";
  #  options = "--delete-older-than 14d";
  #};


  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # Kommentar von Manuel nicht loeschen oder aendern!!!!!!
  system.stateVersion = "25.11";
}

