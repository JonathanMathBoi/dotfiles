{
  lib,
  config,
  pkgs,
  ...
}:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.gaming;
in
{
  options.dots.desktop.gaming.prism = {
    enable = mkGatedEnable cfg "prism minecraft launcher";
  };

  config = mkIf cfg.prism.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
