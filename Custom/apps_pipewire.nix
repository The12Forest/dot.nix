{ config, pkgs, ... }:

{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # Required for Carla, Ardour, and pro-audio routing
  };

  environment.systemPackages = with pkgs; [
    # carla
    # qpwgraph
    # lsp-plugins
    # dragonfly-reverb # High-quality concert/hall/room reverbs
    # pavucontrol
    easyeffects
    ardour
  ];
}
