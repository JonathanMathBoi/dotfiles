{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.dots.desktop.gaming;
in
{
  options.dots.desktop.gaming.prism = {
    enable = mkEnableOption "prism minecraft launcher";
  };

  config = mkIf (cfg.enable && cfg.prism.enable) {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
