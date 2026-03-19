{ lib, config, ... }:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.creative;
in
{
  options.dots.desktop.creative.obs.enable = mkGatedEnable cfg "OBS";

  config = mkIf cfg.obs.enable {
    programs.obs-studio.enable = true;
  };
}
