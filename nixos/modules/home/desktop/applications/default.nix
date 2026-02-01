{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  imports = [
    ./discord.nix
    ./xournalpp.nix
  ];
}
