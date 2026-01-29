{ lib, config, ... }:

with lib;
let
  cfg = config.desktop;
in
{
  config = mkIf (cfg.enable && cfg.discord.enable) {
    programs.discord.enable = true;
  };
}
