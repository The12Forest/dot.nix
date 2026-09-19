{ config, lib, pkgs, ... }:

{
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    steam
    firefox
    thunderbird
    gnome-terminal
    vscode
    vlc
    heroic
    curl
    git
    btop
    fastfetch
    tree
    remmina
    moonlight-qt
    gnome-session  
    xorg-server
    # Minecraft und Java
    modrinth-app
    #temurin-bin-8
    #temurin-bin-17
    temurin-bin-21
    jq
    pciutils
    termius
    discord
    davinci-resolve
    onlyoffice-desktopeditors
    home-manager
    gnomeExtensions.clipboard-history
    s-tui
    powerstat
    arduino-ide
    python3
    dnsutils
    flameshot
    nodejs
    antigravity
    google-chrome
    chromium
    brave
    orca-slicer
    craftos-pc
    fritzing
    whatsie
    twingate   
    playwright-driver.browsers
    opencode
    gnome-boxes
    claude-desktop
    # p3x-onenote
  ];

    nixpkgs.overlays = [
    (self: super: 
      let
        claude-repo = super.fetchFromGitHub {
          owner = "aaddrick";
          repo = "claude-desktop-debian";
          rev = "main";
          sha256 = "sha256-z2nbpF2MzpZQ6tdF+/voSgRfEMEz6C2xXZDBAAErDk0="; 
        };
        
        flake-compat = import (super.fetchFromGitHub {
          owner = "edolstra";
          repo = "flake-compat";
          rev = "master";
          sha256 = "sha256-vNpUSpF5Nuw8xvDLj2KCwwksIbjua2LZCqhV1LNRDns=";
        }) { src = claude-repo; };
      in {
        claude-desktop = flake-compat.defaultNix.packages.${super.system}.claude-desktop;
      }
    )
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };
}
