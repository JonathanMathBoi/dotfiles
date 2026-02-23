{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop.gaming;
in
{
  imports = [
    ./mangohud.nix
    ./prism.nix
  ];

  options.dots.desktop.gaming = {
    enable = mkEnableOption "gaming tools";
  };
}
