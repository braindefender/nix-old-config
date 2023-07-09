{ pkgs, ... }:

{

  fonts = {
    fonts = with pkgs; [
      corefonts # MS Windows Fonts
      cantarell-fonts # GNOME 3 Default Font
      noto-fonts
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override {
        fonts = ["CascadiaCode" "FiraCode" "JetBrainsMono"];
      })
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };

      defaultFonts = {
        emoji = ["Segoe UI Emoji" "Noto Fonts Emoji"];
      };

      subpixel.lcdfilter = "default";
    };
  };
}
