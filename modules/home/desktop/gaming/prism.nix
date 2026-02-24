{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.dots.desktop.gaming;
  dotsLib = import ../../../lib.nix { inherit lib; };
in
{
  options.dots.desktop.gaming.prism = {
    enable = dotsLib.mkGatedEnable cfg "prism minecraft launcher";
  };

  config = mkIf cfg.prism.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
