{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.dots.desktop;
  dotsLib = import ../../../lib.nix { inherit lib; };
in
{
  options.dots.desktop = {
    xournalpp.enable = dotsLib.mkGatedEnable cfg "xournalpp";
  };

  config = mkIf cfg.xournalpp.enable {
    home.packages = with pkgs; [
      xournalpp
    ];
  };
}
