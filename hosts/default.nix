{ lib, inputs, nixpkgs, home-manager, user, name, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user name; };
    modules = [
      ./desktop
      ./hardware.nix
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
	home-manager.users.${user} = {
	  imports = [(import ./home.nix)];
	};
      }
    ];
  };
}
