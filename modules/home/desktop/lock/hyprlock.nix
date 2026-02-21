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
        hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'
        hyprctl --instance 0 'dispatch exec hyprlock'
      '')
    ];
  };
}
