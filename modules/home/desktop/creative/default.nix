{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop.creative;
in
{
  imports = [
    ./krita.nix
  ];

  options.dots.desktop.creative = {
    enable = mkEnableOption "creative apps";
  };
}
