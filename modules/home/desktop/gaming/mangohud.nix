{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.dots.desktop.gaming;
in
{
  options.dots.desktop.gaming.mangohud = {
    enable = mkEnableOption "mangohud";
  };

  config = mkIf (cfg.enable && cfg.mangohud.enable) {
    programs.mangohud.enable = true;
  };
}
