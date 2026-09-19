{ config, pkgs, ... }:

{
  environment.shellAliases = {
    update = "sudo nixos-rebuild switch";
    _update = "home-manager switch";
    ud = "update";
    _ud = "_update";
    upgrade = "sudo nixos-rebuild switch --upgrade";
    gpu = "watch -n 0.1 nvidia-smi";
    cpu = "sudo powerstat -R -d 0 -i 1";
    cpu_all = "s-tui";
    cpu_all_laptop = "sudo powertop";
    taskmgr = "btop";
    info = "fastfetch";
    gc = "sudo nix-env --delete-generations +5 --profile /nix/var/nix/profiles/system && nix-env --delete-generations +5 --profile ~/.local/state/nix/profiles/home-manager && sudo nix-collect-garbage && sudo nixos-rebuild boot";
    gc-list = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    c = "clear";
    wait = "sudo cat /dev/urandom | grep 123233322";
    all = "sudo ls / && c && ud && c && cpu && c && cpu_all && gpu && taskmgr && gc-list && read -p \"Press enter to continue...\" s && gc && c && gc-list && read -p \"Press enter to continue...\" s && c";
  };
}
