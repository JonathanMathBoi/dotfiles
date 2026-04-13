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
    zmkStudio.enable = mkGatedEnable cfg "ZMK Studio" // {
      default = true;
    };
  };

  config = mkIf cfg.zmkStudio.enable {
    home.packages = with pkgs; [
      zmk-studio
    ];
  };
}
