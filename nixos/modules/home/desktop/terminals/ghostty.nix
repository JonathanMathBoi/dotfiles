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

        window-decoration = false;
        confirm-close-surface = false;
      };
    };

    # Disable Nix/Home Manager managed catppuccin theme for ghostty
    # since I don't love the purple background
    catppuccin.alacritty.enable = false;
  };
}
