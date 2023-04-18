{
  description = "NixOS configuration by @braindefender";

  # Define channels
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { 
    self, 
    nixpkgs, 
    home-manager, 
    ... 
  }:
  let
    inherit (self) outputs;
    user = "brain";
    name = "Nikita Shirokov";
    system = "x86_64-linux"; # can also be "aarch-64-linux"

    # forEachSystem = f: nixpkgs.lib.genAttrs ["x86_64-linux"];
    # forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
  in  
  {
    # System configuration
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs user name system; };
        modules = [ ./hosts/desktop ];
      };
    };

    # User configuration
    homeConfigurations = {
      "${user}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${system}";
        extraSpecialArgs = { inherit inputs outputs user name; };
	modules = [ ./home ];
      };
    };
  };
}
