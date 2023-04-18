{ config, lib, pkgs, inputs, outputs, user, ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  manual = {
    html.enable = true;
    json.enable = false;
    manpages.enable = true;
  };

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = false;
      createDirectories = false;
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
    homeDirectory = "/home/${user}";
    stateVersion = "22.11";
  };
}
