{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shell
  ];

  home.packages = with pkgs; [
    # bc #
    # bottom #
    # catimg #
    du-dust
    # fd #
    # file #
    # jq #
    killall
    man-pages
    man-pages-posix
    # procs #
    # psmisc #
    ranger
    # trash-cli #
    # util-linux #
    yt-dlp

    # Nix # TODO: Check what packages do?
    any-nix-shell
    # cached-nix-shell
    # nix-index
    alejandra # Nix Formatter
    deadnix # Nix Dead-code
    statix # Nix Linter
  ];

  programs = {
    exa.enable = true;
    gpg.enable = true;
    man.enable = true;
    ssh.enable = true;
    bat.enable = true;

    fzf.enable = true;
    fzf.enableZshIntegration = true;

    dircolors.enable = true;
    dircolors.enableZshIntegration = true;

    git = {
      enable = true;
      lfs.enable = true;
      userName = "Nikita Shirokov";
      userEmail = "braindefender@gmail.com";
    };

    # nix-index = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };

    # direnv = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   nix-direnv.enable = true;
    # };
  };
}
