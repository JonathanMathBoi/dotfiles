{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  options.dots.desktop = {
    discord.enable = mkOption {
      type = lib.types.bool;
      default = true;
      example = true;
      description = "Whether to enable discord.";
      apply = v: v && cfg.enable;
    };
  };

  config = mkIf cfg.discord.enable {
    programs.discord.enable = true;
  };
}
