{ lib, config, ... }:

with lib;
let
  cfg = config.desktop;
in
{
  imports = [
    ./discord.nix
    ./xournalpp.nix
  ];

  options.desktop = {
    discord.enable = mkOption {
      type = lib.types.bool;
      default = true;
      example = true;
      description = "Whether to enable discord.";
    };

    xournalpp.enable = mkEnableOption "xournalpp";
  };
}
