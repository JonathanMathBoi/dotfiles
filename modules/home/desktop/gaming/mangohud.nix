{
  lib,
  config,
  ...
}:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.gaming;
in
{
  options.dots.desktop.gaming.mangohud = {
    enable = mkGatedEnable cfg "mangohud";
  };

  config = mkIf cfg.mangohud.enable {
    programs.mangohud.enable = true;
  };
}
