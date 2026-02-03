{ config, lib, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.ghostty.enable) {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
