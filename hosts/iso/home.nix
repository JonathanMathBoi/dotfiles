{ inputs, lib, pkgs, ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/desktop
  ];

  # Copy dotfiles to ~/dotfiles as a writable directory so that tools like
  # lazy.nvim can write lock files into the config tree, replicating how
  # a real machine has a writable git clone at ~/dotfiles.
  home.activation.setupDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD rm -rf $HOME/dotfiles
    $DRY_RUN_CMD cp -rT --no-preserve=mode ${inputs.self} $HOME/dotfiles
  '';

  # Pre-seed lazy.nvim so neovim starts without requiring network for initial bootstrap.
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
