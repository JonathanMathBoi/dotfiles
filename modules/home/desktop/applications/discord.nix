{ lib, config, ... }:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop;
in
{
  options.dots.desktop = {
    discord.enable = mkGatedEnable cfg "discord" // {
      default = true;
    };
  };

  config = mkIf cfg.discord.enable {
    programs.discord.enable = true;
  };
}
