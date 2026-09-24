{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zmk-nix = {
      url = "github:lilyinstarlight/zmk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      disko,
      nixos-hardware,
      impermanence,
      treefmt-nix,
      sops-nix,
      zmk-nix,
      hyprland,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      treefmtEval = treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        programs.stylua.enable = true;
      };
    in
    {
      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatting = treefmtEval.config.build.check self;

      homeConfigurations."jonathan@portable" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./profiles/portable.nix
          catppuccin.homeModules.catppuccin
        ];
      };

      packages.x86_64-linux.iso = self.nixosConfigurations.iso.config.system.build.isoImage;

      packages.x86_64-linux.lily58 = import ./keyboards/lily58 { inherit pkgs zmk-nix system; };
      packages.x86_64-linux.v1-ultra = import ./keyboards/v1_ultra {
        inherit pkgs;
        inherit zmk-nix system;
        lib = pkgs.lib;
      };

      nixosConfigurations = {
        iso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/iso/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.jonathan = {
                imports = [
                  ./hosts/iso/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
          ];
        };

        forest = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/forest/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
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
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.jonathan = {
                imports = [
                  ./hosts/meadow/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
          ];
        };

        jungle = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/jungle/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.jonathan = {
                imports = [
                  ./hosts/jungle/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
          ];
        };
      };
    };
}
