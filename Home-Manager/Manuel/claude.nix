{ config, pkgs, ... }:

{
  
  xdg.desktopEntries = {
    # 1. Privater Account (steka.ch)
    claude-personal = {
      name = "Claude (manuel@steka.ch)";
      genericName = "AI Chat Client";
      exec = "env CLAUDE_CONFIG_DIR=${config.home.homeDirectory}/.config/claude-code-steka claude-desktop --user-data-dir=${config.home.homeDirectory}/.config/Claude-steka";
      icon = "${pkgs.claude-desktop}/share/icons/hicolor/256x256/apps/claude-desktop.png";
      comment = "Claude mit manuel@steka.ch starten";
      categories = [ "Utility" "Network" ];
      terminal = false;
    };
    
    # 2. Geschäftlicher Account (wnw.li)
    claude-wnw = {
      name = "Claude (manuel@wnw.li)";
      genericName = "AI Chat Client";
      exec = "env CLAUDE_CONFIG_DIR=${config.home.homeDirectory}/.config/claude-code-wnw claude-desktop --user-data-dir=${config.home.homeDirectory}/.config/Claude-wnw";
      icon = "${pkgs.claude-desktop}/share/icons/hicolor/256x256/apps/claude-desktop.png";
      comment = "Claude mit manuel@wnw.li starten";
      categories = [ "Utility" "Network" ];
      terminal = false;
    };

    # 3. Google/Gmail Account
    claude-gmail = {
      name = "Claude (waldmanuel76@gmail.com)";
      genericName = "AI Chat Client";
      exec = "env CLAUDE_CONFIG_DIR=${config.home.homeDirectory}/.config/claude-code-gmail claude-desktop --user-data-dir=${config.home.homeDirectory}/.config/Claude-gmail";
      icon = "${pkgs.claude-desktop}/share/icons/hicolor/256x256/apps/claude-desktop.png";
      comment = "Claude mit waldmanuel76@gmail.com starten";
      categories = [ "Utility" "Network" ];
      terminal = false;
    };

    claude-waldnetworks = {
      name = "Claude (manuel@waldnetworks.ch)";
      genericName = "AI Chat Client";
      exec = "env CLAUDE_CONFIG_DIR=${config.home.homeDirectory}/.config/claude-code-waldnetworks claude-desktop --user-data-dir=${config.home.homeDirectory}/.config/Claude-waldnetworks";
      icon = "${pkgs.claude-desktop}/share/icons/hicolor/256x256/apps/claude-desktop.png";
      comment = "Claude mit manuel@waldnetworks.ch starten";
      categories = [ "Utility" "Network" ];
      terminal = false;
    };
  };
}
