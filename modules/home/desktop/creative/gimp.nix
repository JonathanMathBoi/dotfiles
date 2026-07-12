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
  options.dots.desktop.creative.gimp = {
    enable = mkGatedEnable cfg "gimp";
  };

  config = mkIf cfg.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
