{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  imports = [
    ./hyprlauncher.nix
  ];

  options.dots.desktop = {
    launcher = mkOption {
      type = types.enum [
        "hyprlauncher"
      ];
      default = "hyprlauncher";
      description = "The app launcher for the DE to use.";
    };
  };
}
