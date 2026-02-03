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

        theme = "alacritty-default";
      };

      themes.alacritty-default = {
        background = "181818";
        foreground = "d8d8d8";

        palette = [
          "0=#181818"
          "1=#ac4242"
          "2=#90a959"
          "3=#f4bf75"
          "4=#6a9fb5"
          "5=#aa759f"
          "6=#75b5aa"
          "7=#d8d8d8"
          "8=#6b6b6b"
          "9=#c55555"
          "10=#aac474"
          "11=#feca88"
          "12=#82b8c8"
          "13=#c28cb8"
          "14=#93d3c3"
          "15=#f8f8f8"
        ];
      };
    };

    # Disable Nix/Home Manager managed catppuccin theme for ghostty
    # since I don't love the purple background
    catppuccin.alacritty.enable = false;
  };
}
