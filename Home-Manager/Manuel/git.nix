{ config, pkgs, ... }:

{
    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "The12Forest";
                email = "manuel@steka.ch";
            };
            alias = {
                pu = "push";
                co = "checkout";
                cm = "commit";
            };
        };
    };
}
