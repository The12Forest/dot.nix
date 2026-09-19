{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/ntfs" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs3";
    options = [ 
      "rw"
      "uid=1000"
      "gid=100"
      "fmask=0022"
      "dmask=0022"
      "nofail"
    ];
  };

  #NAS
  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems."/mnt/Roche-Server" = {
    device = "//10.10.1.1/Main";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [ "${automount_opts},_netdev,credentials=/etc/nixos/Custom/Credentials/SMB.txt,uid=1000,gid=1000,forceuid,forcegid,vers=3.1.1,serverino,soft,x-gvfs-show" ];
  };

  fileSystems."/mnt/Roche-PC" = {
    device = "//10.10.2.1/Main";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [ "${automount_opts},_netdev,credentials=/etc/nixos/Custom/Credentials/SMB.txt,uid=1000,gid=1000,forceuid,forcegid,vers=3.1.1,sec=ntlmsspi,nounix,serverino,soft,x-gvfs-show" ];
  };

  fileSystems."/mnt/3D-Druck-PC" = {
    device = "//10.10.3.1/Main";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [ "${automount_opts},_netdev,credentials=/etc/nixos/Custom/Credentials/SMB.txt,uid=1000,gid=1000,forceuid,forcegid,vers=3.1.1,sec=ntlmsspi,nounix,serverino,soft,x-gvfs-show" ];
  };


  
  # Ensure GVFS is enabled for GNOME Files (Nautilus) integration
  services.gvfs.enable = true;

}