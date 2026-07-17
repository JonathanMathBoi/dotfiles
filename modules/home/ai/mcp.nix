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
  options.dots.ai.mcp.enable = mkGatedEnable cfg "mcp servers" // {
    default = true;
  };

  config = mkIf cfg.mcp.enable {
    # WARN: MCP server installation is decoupled from config
    # TODO: Refactor to merge MCP installation with config
    home.packages = with pkgs; [
      mcp-server-filesystem
      mcp-nixos
    ];

    programs.mcp = {
      enable = true;
      servers = {
        filesystem = {
          command = "${pkgs.mcp-server-filesystem}/bin/mcp-server-filesystem";
          # HACK: Using hardcoded paths
          # Switch to some kind of variable defined paths for portability
          args = [
            "${config.dots.repoPath}"
            "${config.home.homeDirectory}/code"
          ];
        };
        nixos-lookup = {
          command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
        };
      };
    };
  };
}
