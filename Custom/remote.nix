{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];

  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.oci-containers.containers.wolf = {
    image = "ghcr.io/games-on-whales/wolf:stable";
    environment = {
      NVIDIA_DRIVER_CAPABILITIES = "all";
      NVIDIA_VISIBLE_DEVICES = "all";
      WOLF_SOCKET_PATH = "/var/run/wolf/wolf.sock";
      XDG_RUNTIME_DIR = "/tmp/sockets";              # NEU
      HOST_APPS_STATE_FOLDER = "/etc/wolf";          # NEU (empfohlen)
    };
    volumes = [
      "/etc/wolf:/etc/wolf"
      "/var/run/docker.sock:/var/run/docker.sock:rw"
      "/dev:/dev:rw"
      "/run/udev:/run/udev"
      "/var/run/wolf:/var/run/wolf"
      "/tmp/sockets:/tmp/sockets:rw"                 # NEU
    ];
    extraOptions = [
      "--network=host"
      "--device=/dev/dri"
      "--device=/dev/uinput"
      "--device=/dev/uhid"
      "--device-cgroup-rule=c 13:* rmw"
      "--device=nvidia.com/gpu=all"
    ];
  };

  virtualisation.oci-containers.containers.wolf-den = {
    image = "ghcr.io/games-on-whales/wolf-den:stable";
    environment = {
      WOLF_SOCKET_PATH = "/var/run/wolf/wolf.sock";
    };
    volumes = [
      "/etc/wolf/wolf-den:/app/wolf-den"
      "/var/run/wolf:/var/run/wolf"
      "/etc/wolf/covers:/etc/wolf/covers"
    ];
    ports = [ "8080:8080" ];
  };

  # RDP
  #services.xrdp.enable = true;
  #services.xrdp.openFirewall = true;

  # services.gnome.gnome-remote-desktop.enable = true;
  # systemd.services.gnome-remote-desktop = { 
  #   wantedBy = [ "graphical.target" ];
  # };

  #services.displayManager.autoLogin.enable = false;
  #services.xrdp.defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
  #services.xrdp.defaultWindowManager = "gnome-session";
  services.gnome.gnome-remote-desktop.enable = true;


  systemd.services.gnome-remote-desktop = { wantedBy = [ "graphical.target" ];
  };

  # networking.firewall.allowedTCPPorts = [ 3389 ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
