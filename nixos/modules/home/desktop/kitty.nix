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
        font_size = "12.0";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";

        background_opacity = "0.82";
        confirm_os_window_close = 0;
      };
    };

    # Disable Nix/Home Manager managed catppuccin theme for kitty
    # since I don't love the purple background
    catppuccin.kitty.enable = false;
  };
}
