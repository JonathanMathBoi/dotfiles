{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.dots.desktop.creative;
  dotsLib = import ../../../lib.nix { inherit lib; };
in
{
  options.dots.desktop.creative.krita = {
    enable = dotsLib.mkGatedEnable cfg "krita";
  };

  config = mkIf cfg.krita.enable {
    home.packages = with pkgs; [
      krita
    ];
  };
}
