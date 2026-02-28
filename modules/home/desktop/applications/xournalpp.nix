{
  lib,
  config,
  pkgs,
  ...
}:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop;
in
{
  options.dots.desktop = {
    xournalpp.enable = mkGatedEnable cfg "xournalpp";
  };

  config = mkIf cfg.xournalpp.enable {
    home.packages = with pkgs; [
      xournalpp
    ];
  };
}
