{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
  dotsLib = import ../../../lib.nix { inherit lib; };
in
{
  options.dots.desktop = {
    discord.enable = dotsLib.mkGatedEnable cfg "discord" // { default = true; };
  };

  config = mkIf cfg.discord.enable {
    programs.discord.enable = true;
  };
}
