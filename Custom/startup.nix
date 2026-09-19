{ inputs, pkgs, ... }:

let
  macStylePlymouthSrc = pkgs.fetchFromGitHub {
    owner = "Nimrodium";
    repo = "nixos-plymouth-theme";
    rev = "nix";
    sha256 = "sha256-U+MdC/4+VlCcTyXi4NB31vdzszP6MGCF8Zk+QTvBGeo=";
  };

  macStylePlymouthOrig = pkgs.callPackage "${macStylePlymouthSrc}/package.nix" {};

  mac-style-plymouth = pkgs.runCommand "mac-style-plymouth-renamed" {} ''
    mkdir -p $out/share/plymouth/themes
    cp -r ${macStylePlymouthOrig}/share/plymouth/themes/nixos-splash $out/share/plymouth/themes/mac-style
    chmod -R u+w $out/share/plymouth/themes/mac-style
    mv $out/share/plymouth/themes/mac-style/nixos-splash.plymouth $out/share/plymouth/themes/mac-style/mac-style.plymouth
    sed -i \
      -e "s#${macStylePlymouthOrig}#$out#g" \
      -e "s#nixos-splash#mac-style#g" \
      $out/share/plymouth/themes/mac-style/mac-style.plymouth
  '';
#       -e "s#VerticalAlignment=.65#VerticalAlignment=.45#g" \
#       -e "s#ProgressBarVerticalAlignment=.59#ProgressBarVerticalAlignment=.85#g" \
#       -e "s#\[boot-up\]#[boot-up]\nUseProgressBar=true#" \

in
{
  boot.plymouth = {
    enable = true;
    theme = "mac-style";
    themePackages = [ mac-style-plymouth ];
  };

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
}