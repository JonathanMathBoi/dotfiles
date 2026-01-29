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

            # FIXME: Hacky fix until the fix gets into the PR branch and upstream for surface
            # kernel 6.18.7
            (
              {
                config,
                lib,
                pkgs,
                ...
              }:
              let
                srcVersion = "6.18.7";
                srcHash = "sha256-tyak0Vz5rgYhm1bYeCB3bjTYn7wTflX7VKm5wwFbjx4=";

                linux-surface = pkgs.fetchFromGitHub {
                  owner = "linux-surface";
                  repo = "linux-surface";
                  rev = "7d273267d9af19b3c6b2fdc727fad5a0f68b1a3d";
                  hash = "sha256-CPY/Pxt/LTGKyQxG0CZasbvoFVbd8UbXjnBFMnFVm9k=";
                };

                inherit
                  (pkgs.callPackage "${inputs.nixos-hardware}/microsoft/surface/common/kernel/linux-package.nix" { })
                  linuxPackage
                  surfacePatches
                  ;
                kernelPatches = surfacePatches {
                  version = srcVersion;
                  patchFn = "${inputs.nixos-hardware}/microsoft/surface/common/kernel/${lib.versions.majorMinor srcVersion}/patches.nix";
                  patchSrc = (linux-surface + "/patches/${lib.versions.majorMinor srcVersion}");
                };
                kernelPackages = linuxPackage {
                  inherit kernelPatches;
                  version = srcVersion;
                  sha256 = srcHash;
                  ignoreConfigErrors = true;
                };
              in
              {
                boot.kernelPackages = lib.mkForce kernelPackages;
              }
            )
            # End hack

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
