{ config, pkgs, ... }:

{
    programs.bash = {
        enable = true;
        enableCompletion = true;

        historySize = 200;
        historyFileSize = 200000;
        historyControl = [ "ignoreboth" ];


        shellOptions = [
            "histappend"
        ];
    };
}
