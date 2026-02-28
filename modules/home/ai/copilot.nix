{
  lib,
  config,
  pkgs,
  ...
}:

with lib // (import ../../lib.nix { inherit lib; });
let
  cfg = config.dots.ai;
in
{
  options.dots.ai = {
    copilot.enable = mkGatedEnable cfg "copilot cli";
  };

  config = mkIf cfg.copilot.enable {
    home.packages = [ pkgs.github-copilot-cli ];
  };
}
