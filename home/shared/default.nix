{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./shell.nix
    ./packages.nix
    ./services.nix
    ./hyprland.nix
    ./vscode.nix
  ];

  # manual = {
  #   html.enable = true;
  #   json.enable = false;
  #   manpages.enable = true;
  # };

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  nix = {
    package = lib.mkForce pkgs.nixUnstable;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/brain";
    stateVersion = "22.11";
  };
}
