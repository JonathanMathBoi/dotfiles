{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.hyprlock.enable) {
    programs.hyprlock.enable = true;

    # Script for quickly recovering from a hyprlock crash from TTY
    home.packages = [
      (pkgs.writeShellScriptBin "hyprlock-recover" ''
        loginctl unlock-session && pkill hyprlock || true
      '')
    ];
  };
}
