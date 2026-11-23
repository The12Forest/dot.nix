{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Fixes nvidia-drm/Wayland freezes:
  # "mapping multiple BARs" / "Failed to map NvKmsKapiMemory" -> disable Resizable BAR
  # "Failed to apply atomic modeset" -> preserve video memory + fbdev fallback
  boot.extraModprobeConfig = ''
    options nvidia NVreg_EnableResizableBar=0
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia_drm fbdev=1
  '';

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
