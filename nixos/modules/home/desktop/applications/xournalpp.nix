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
  config = mkIf (cfg.enable && cfg.xournalpp.enable) {
    home.packages = with pkgs; [
      xournalpp
    ];
  };
}
