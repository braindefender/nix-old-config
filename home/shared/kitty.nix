{...}: {
  programs.kitty = {
    enable = true;

    theme = "Catppuccin-Macchiato";
    font.name = "CaskaydiaCove Nerd Font Mono";
    settings = {
      window_padding_width = "1 5";
      enable_audio_bell = false;
    };
  };
}
