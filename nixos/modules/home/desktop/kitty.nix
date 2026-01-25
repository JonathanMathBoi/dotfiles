{ config, lib, ... }:

let
  cfg = config.desktop;
in
{
  config = lib.mkIf (cfg.enable && cfg.kitty.enable) {
    programs.kitty = {
      enable = true;
      settings = {
        font_family = "JetBrainsMono NF";
        font_size = "11.25";

        text_composition_strategy = "legacy";

        # Foreground and background colors copied from alacritty default
        foreground = "#d8d8d8";
        # Altered from alacritty #181818 because kitty refuses to do sRGB normal rendering
        background = "#111111";
        background_opacity = "0.82";
        confirm_os_window_close = 0;
      };
    };

    # Disable Nix/Home Manager managed catppuccin theme for kitty
    # since I don't love the purple background
    catppuccin.kitty.enable = false;
  };
}
