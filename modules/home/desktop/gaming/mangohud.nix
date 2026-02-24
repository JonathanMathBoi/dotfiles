{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.dots.desktop.gaming;
  dotsLib = import ../../../lib.nix { inherit lib; };
in
{
  options.dots.desktop.gaming.mangohud = {
    enable = dotsLib.mkGatedEnable cfg "mangohud";
  };

  config = mkIf cfg.mangohud.enable {
    programs.mangohud.enable = true;
  };
}
