{ lib, config, ... }:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.gaming;
  deskCfg = config.dots.desktop;
in
{
  imports = [
    ./mangohud.nix
    ./prism.nix
  ];

  options.dots.desktop.gaming = {
    enable = mkGatedEnable deskCfg "gaming tools";
  };
}
