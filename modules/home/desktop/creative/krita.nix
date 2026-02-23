{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.dots.desktop.creative;
in
{
  options.dots.desktop.creative.krita = {
    enable = mkEnableOption "krita";
  };

  config = mkIf (cfg.enable && cfg.krita.enable) {
    home.packages = with pkgs; [
      krita
    ];
  };
}
