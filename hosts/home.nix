{ config, lib, pkgs, user, ...}:

{
  home = {
    stateVersion = "22.11";
    
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Video/Audio
      feh
      mpv
      vlc
    ];

    # UI Cursor
    pointerCursor = {
      x11.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  # UI Theme
  gtk = {
    enable = true;
    theme = {
      # TODO: change UI theme
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      # TODO: change icon theme
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      # TODO: change UI font
      name = "FiraCode Nerd Font Mono Medium";
    };
  };

  # Wallpaper
  home.file.".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../modules/themes/wall;
}
