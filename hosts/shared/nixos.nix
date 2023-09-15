{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}: {
  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;

    # Define Nix packages platform
    hostPlatform = lib.mkDefault system;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
      max-jobs = "auto";
      keep-outputs = true;
      keep-derivations = true;
    };

    # Gabrage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # TODO: Check nixFlakes vs nixUnstable
    package = pkgs.nixFlakes;

    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # TODO: Check what is nixPath
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };

  system = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";

    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
}
