{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }:
    {
      nixosConfigurations = {
        forest = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/forest/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathan = {
                imports = [
                  ./hosts/forest/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
          ];
        };
      };
    };
}
