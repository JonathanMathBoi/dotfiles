{ lib, config, ... }:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.creative;
  deskCfg = config.dots.desktop;
in
{
  imports = [
    ./krita.nix
  ];

  options.dots.desktop.creative = {
    enable = mkGatedEnable deskCfg "creative apps";
  };
}
