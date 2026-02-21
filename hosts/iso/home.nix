{ inputs, pkgs, ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/desktop
  ];

  home.file."dotfiles".source = inputs.self;

  # Pre-seed lazy.nvim from the Nix store so the bootstrap git-clone is skipped.
  # Without this, neovim crashes on first launch because there is no network on the ISO.
  home.file.".local/share/nvim/lazy/lazy.nvim".source = pkgs.vimPlugins.lazy-nvim;

  dots.desktop = {
    enable = true;
    gaming.enable = false;
    creative.enable = false;
  };

  # Generic monitor config — let Hyprland pick the best mode automatically
  xdg.configFile."hypr/monitors.conf".text = ''
    monitor=,preferred,auto,1
  '';

  services.hyprpaper.settings = {
    preload = [ "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg" ];
    wallpaper = [
      {
        monitor = "";
        path = "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg";
      }
    ];
  };

  programs.hyprlock.settings = {
    background = [
      {
        path = "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg";
        blur_size = 4;
        blur_passes = 3;
        noise = 0.0117;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      }
    ];
  };
}
