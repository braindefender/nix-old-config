{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      histSize = 100000;

      ohMyZsh = {
        enable = true;
	plugins = [ "git" ];
      };
    };
  };
}
