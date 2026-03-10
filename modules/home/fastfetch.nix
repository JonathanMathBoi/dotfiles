{ lib, config, ... }:

with lib // (import ../lib.nix { inherit lib; });
let
  cfg = config.dots;
in
{
  options.dots.fastfetch.enable = mkGatedEnable cfg "fastfetch" // {
    default = true;
  };

  config = mkIf cfg.fastfetch.enable {
    programs.fastfetch.enable = true;
  };
}
