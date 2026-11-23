{ config, pkgs, lib, ... }:

let
  gyroflow-tarball = pkgs.fetchurl {
    url = "https://github.com/gyroflow/gyroflow/releases/download/v1.6.3/Gyroflow-linux64.tar.gz";
    sha256 = "98625e3ce318964d49d3c66f2dc302a9e6c4c138233d9aa6cbd986f687c421c3";
  };

  gyroflow-icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gyroflow/gyroflow/v1.6.3/resources/icon.svg";
    sha256 = "847ac94756cb80317c2cb716790c4fded707236eaecbf6c9611d27124c442578";
  };

  gyroflow-unwrapped = pkgs.stdenv.mkDerivation {
    pname = "gyroflow-unwrapped";
    version = "1.6.3";
    src = gyroflow-tarball;
    installPhase = ''
      mkdir -p $out/opt/gyroflow
      cp -r . $out/opt/gyroflow
      chmod +x $out/opt/gyroflow/gyroflow
    '';
  };

  gyroflow-fhs = pkgs.buildFHSEnv {
    name = "gyroflow";
    targetPkgs = pkgs: with pkgs; [
      alsa-lib libva libvdpau libxkbcommon vulkan-loader
      ocl-icd opencl-headers wayland libGL
      libgbm
      libcxx
      zlib
      xorg.libX11 xorg.libxcb
      libdrm
      libpulseaudio
      mesa libglvnd
      glib
      fontconfig
      freetype
      dbus
      krb5
    ];
    runScript = pkgs.writeShellScript "gyroflow-run" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec ${gyroflow-unwrapped}/opt/gyroflow/gyroflow "$@"
    '';
  };

  gyroflow-desktop = pkgs.makeDesktopItem {
    name = "gyroflow";
    exec = "gyroflow";
    icon = "gyroflow";
    desktopName = "Gyroflow";
    genericName = "Video Stabilizer";
    categories = [ "AudioVideo" "Video" ];
  };

  gyroflow = pkgs.symlinkJoin {
    name = "gyroflow";
    paths = [ gyroflow-fhs gyroflow-desktop ];
    postBuild = ''
      mkdir -p $out/share/icons/hicolor/scalable/apps
      cp ${gyroflow-icon} $out/share/icons/hicolor/scalable/apps/gyroflow.svg
    '';
  };
in
{
  environment.systemPackages = [ gyroflow ];
}