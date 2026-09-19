{ config, pkgs, ... }:

let
  userAvatar = pkgs.fetchurl {
    url = "https://gravatar.com/avatar/352b31a0ff9ba5213c9ca8f479c73552f2ab618f2306f74876b8cb6135be058e";
    hash = "sha256-Vum+YYcH+M5W6Qy59M8GlZGEcf+ZrhhC+2+TesH0IKU="; 
  };

  myWallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/The12Forest/The12Forest/main/media/background/bg_fpv.jpg";
    sha256 = "sha256-L9VR0OuAOVIUjawv7k4Z9732K5Il8Q3NX7ZtK2ph+QE="; 
  };
in
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file://${myWallpaper}";
      picture-uri-dark = "file://${myWallpaper}";
      picture-options = "fill"; 
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${myWallpaper}";
      picture-options = "zoom";
    };

    # Set num of virtual desktops.
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
    };


    #Set Clipboard history
    "org/gnome/shell" = {
      enabled-extensions = [
        "clipboard-history@manouchehr" 
      ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      toggle-message-tray = [ "<Super>m" ];
    };

    "org/gnome/shell/extensions/clipboard-history" = {
      toggle-menu = [ "<Super>v" ];
      history-size = 100;          # Speichert die letzten 100 Einträge
      move-item-first = true;      # Bringt erneut kopierte Elemente nach oben
    };
  };

  home.file.".face".source = userAvatar;
  home.file.".face.icon".source = userAvatar;
}