{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
	vm = nixpkgs.lib.nixosSystem {
	  modules = [
	    ./hosts/vm/configuration.nix
	    home-manager.nixosModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.jonathan = import ./hosts/vm/home.nix;
	    }
	  ];
	};

        forest = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
	  modules = [
	    ./hosts/forest/configuration.nix
	    home-manager.nixosModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.jonathan = import ./hosts/forest/home.nix;
	    }
          ];
        };
      };
    };
}
