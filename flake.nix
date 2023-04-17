{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
  let
    user = "brain";
    name = "Nikita Shirokov";
  in  
  {
    nixosConfigurations = (
      import ./hosts {
	inherit (nixpkgs) lib;
	inherit inputs nixpkgs home-manager user name;
      }
    );
  };
}
