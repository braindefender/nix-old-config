{
  description = "NixOS configuration by @braindefender";

  # Define channels
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nur,
    hyprland,
    home-manager,
    ...
  }: let
    user = "brain";
    name = "Nikita Shirokov";
    system = "x86_64-linux"; # can also be "aarch-64-linux"
  in {
    # System configuration
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nur hyprland home-manager user name system;
      }
    );
  };
}
