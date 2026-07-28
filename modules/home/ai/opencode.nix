{
  lib,
  config,
  ...
}:

with lib // (import ../../lib.nix { inherit lib; });
let
  cfg = config.dots.ai;
in
{
  options.dots.ai.opencode.enable = mkGatedEnable cfg "opencode";

  config = mkIf cfg.opencode.enable {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = cfg.mcp.enable;

      settings = {
        theme = "catppuccin-macchiato";
      };

      # TODO: Declaritive API config
      # TODO: Look into formatters
    };
  };
}
