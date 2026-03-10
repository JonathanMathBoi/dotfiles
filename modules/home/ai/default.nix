{ lib, config, ... }:

with lib // (import ../../lib.nix { inherit lib; });
let
  cfg = config.dots.ai;
  dotsCfg = config.dots;
in
{
  imports = [
    ./copilot.nix
  ];

  options.dots.ai = {
    enable = mkGatedEnable dotsCfg "ai tooling";
  };
}
