{ ... }:

let
  wallpaper_image = "~/dotfiles/wallpapers/longwood_gardens_june_2025_1920x1200.png";
in
{
  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,1920x1200@60,0x0,1.07"
  ];

  services.hyprpaper.settings = {
    preload = [ wallpaper_image ];
    wallpaper = [
      {
        monitor = "eDP-1";
        path = wallpaper_image;
      }
    ];
  };

  programs.hyprlock.settings = {
    background = [
      {
        monitor = "eDP-1";
        path = wallpaper_image;
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
