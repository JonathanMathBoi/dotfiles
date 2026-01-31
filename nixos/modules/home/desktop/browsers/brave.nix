{ config, lib, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.brave.enable) {
    programs.brave.enable = true;
  };
}
