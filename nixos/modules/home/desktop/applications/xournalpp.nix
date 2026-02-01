{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.dots.desktop;
in
{
  options.dots.desktop = {
    xournalpp.enable = mkEnableOption "xournalpp";
  };

  config = mkIf (cfg.enable && cfg.xournalpp.enable) {
    home.packages = with pkgs; [
      xournalpp
    ];
  };
}
