{ ... }:

{
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

  # Disable Nix/Home Manager managed catppuccin theme for alacritty since I already manage it myself
  catppuccin.alacritty.enable = false;
}
