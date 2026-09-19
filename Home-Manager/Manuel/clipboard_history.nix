{ pkgs, ... }: {
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "clipboard-history@alexsaveau.dev" # Or the UUID of your preferred extension
      ];
    };
  };
}