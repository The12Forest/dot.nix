{ config, lib, pkgs, ... }:

{
  users.users.manuel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" "docker" ]; # Enable ‘sudo’ for the user.
  };
  home-manager.users.manuel = import ../Home-Manager/Manuel/home.nix;


  #users.users.david = {
  #  isNormalUser = true;
  #  # extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #};
}