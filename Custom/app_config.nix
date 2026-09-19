{ config, lib, pkgs, ... }:


{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    host = "0.0.0.0";
    loadModels = [ 
      "qwen3.5:9b" 
      "qwen3.5:4b" 
      "granite4.1:8b" 
      "qwen3-vl:8b" 
      "qwen2.5-coder:14b" 
      "llama3.1:8b" 
      "llama3.2:3b" 
      "llama3.2:1b" 
      "llama2:13b" 
      "llama2:7b" 
      "llama2-uncensored:7b" 
      "llama3-gradient:8b" 
      "glm4:9b" 
      "deepseek-r1:14b" 
      "deepseek-r1:7b" 
      "deepseek-r1:8b" 
      "deepseek-r1:1.5b" 
    ];
  };

  # Modrinth
  environment.sessionVariables = {
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
  };

  #Sudo
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "manuel" ];
        groups = [ "wheel" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", MODE="0660", GROUP="dialout"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0660", GROUP="dialout"
  '';
  services.envfs.enable = true;

  # Playwright Browser
  environment.sessionVariables = {
    PLAYWRIGHT_CHROMIUM_BIN = "${pkgs.brave}/bin/brave";
  };

  # Beszel
  imports = [ ./app_config_beszel.nix ];

  # VirtBox
  virtualisation.libvirtd.enable = true;

  # Allows GUI applications like virt-manager to save window settings/preferences
  programs.dconf.enable = true;

  # Enables the host daemon for SPICE communication (clipboard/mouse synchronization)
  services.spice-vdagentd.enable = true;

  # Optional environment packages needed for advanced spice video scaling and display
  environment.systemPackages = with pkgs; [
    spice-gtk
    virt-viewer
  ];
  
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ 
    virtiofsd 
  ];

}