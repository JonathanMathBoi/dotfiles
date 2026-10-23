{
  lib,
  config,
  pkgs,
  ...
}:

with lib // (import ../../lib.nix { inherit lib; });
let
  cfg = config.dots.finance;
in
{
  options.dots.finance.hledger.enable = mkGatedEnable cfg "hledger" // {
    default = true;
  };

  config = mkIf cfg.hledger.enable {
    home.packages = [ pkgs.hledger ];
  };
}
