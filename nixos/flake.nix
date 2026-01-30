{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # FIXME: Switch to main nixos-hardware branch when PR is merged
    nixos-hardware.url = "github:8bitbuddhist/nixos-hardware/surface-kernel-6.18";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      disko,
      nixos-hardware,
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

        meadow = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/meadow/configuration.nix
            disko.nixosModules.disko
            nixos-hardware.nixosModules.microsoft-surface-go
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathan = {
                imports = [
                  ./hosts/meadow/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
          ];
        };
      };
    };
}
