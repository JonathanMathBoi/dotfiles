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
  options.dots.desktop.creative.kdenlive = {
    enable = mkGatedEnable cfg "kdenlive";
  };

  config = mkIf cfg.kdenlive.enable {
    home.packages = with pkgs; [
      kdePackages.kdenlive
    ];
  };
}
