{ lib, config, ... }:

with lib // (import ../lib.nix { inherit lib; });
let
  cfg = config.dots;
in
{
  options.dots.gh.enable = mkGatedEnable cfg "GitHub CLI" // {
    default = true;
  };

  config = mkIf cfg.gh.enable {
    programs.gh.enable = true;

    # TODO: Add token to sops for easy auth
  };
}
