{ config, lib, pkgs, ... }:

let
  mySecrets = import ./Credentials/Beszel.nix;
in
{
  services.beszel.agent = {
    enable = true;
    openFirewall = true;
    
    # Only keep the valid Nix package reference here
    extraPath = [ config.boot.kernelPackages.nvidia_x11.bin ];
    
    environment = {
      LISTEN = "45876";
      KEY = mySecrets.beszelKey;
      GPU_COLLECTOR = "nvidia-smi"; 
    };
  };

  # Relax sandboxing restrictions so the agent can access your GPU devices
  systemd.services.beszel-agent.serviceConfig = {
    PrivateDevices = lib.mkForce false;
    ProtectLayeredSysfs = false;
  };
  
  # Inject the driver directories directly into the Systemd service environment
  systemd.services.beszel-agent.path = [ "/run/opengl-driver" ];
  systemd.services.beszel-agent.environment.LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
}
