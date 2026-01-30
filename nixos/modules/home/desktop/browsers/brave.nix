{ config, lib, ... }:

with lib;
let
  cfg = config.desktop;
in
{
  config = mkIf (cfg.enable && cfg.brave.enable) {
    programs.brave.enable = true;
  };
}
