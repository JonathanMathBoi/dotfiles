{ lib, config, ... }:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.creative;
  deskCfg = config.dots.desktop;
in
{
  imports = [
    ./krita.nix
    ./obs.nix
    # TODO: Add GIMP
    # TODO: ADD Kdenlive
  ];

  options.dots.desktop.creative = {
    enable = mkGatedEnable deskCfg "creative apps";
  };
}
