{ config, lib, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.alacritty.enable) {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
          };
        };

        window = {
          opacity = 0.82;
        };
      };
    };

    # Disable Nix/Home Manager managed catppuccin theme for alacritty
    # since I don't love the purple background
    catppuccin.alacritty.enable = false;
  };
}
