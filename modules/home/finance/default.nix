{ lib, config, ... }:

with lib // (import ../../lib.nix { inherit lib; });
let
  cfg = config.dots.finance;
  dotsCfg = config.dots;
in
{
  imports = [
    ./hledger.nix
  ];

  options.dots.finance.enable = mkGatedEnable dotsCfg "finance tools";
}
