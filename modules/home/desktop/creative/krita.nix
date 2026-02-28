{
  lib,
  config,
  pkgs,
  ...
}:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.creative;
in
{
  options.dots.desktop.creative.krita = {
    enable = mkGatedEnable cfg "krita";
  };

  config = mkIf cfg.krita.enable {
    home.packages = with pkgs; [
      krita
    ];
  };
}
