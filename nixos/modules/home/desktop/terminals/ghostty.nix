{ config, lib, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.ghostty.enable) {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        font-family = "JetBrainsMono Nerd Font";
        font-size = 11.25;

        background-opacity = 0.82;
        alpha-blending = "native";

        # Performance & Integration (recommended for your stack)
        # window-decoration = false; # Clean look like Alacritty
        # confirm-close-surface = false; # Don't prompt when closing via tmux
      };
    };
  };
}
