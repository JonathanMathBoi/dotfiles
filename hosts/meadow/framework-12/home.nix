{ ... }:

{
  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,1920x1200@60,0x0,1.07"
  ];

  services.hyprpaper.settings = {
    preload = [ "~/dotfiles/wallpapers/longwood_gardens_april_2026_1920x1200.jpg" ];
    wallpaper = [
      {
        monitor = "eDP-1";
        path = "~/dotfiles/wallpapers/longwood_gardens_april_2026_1920x1200.jpg";
      }
    ];
  };

  programs.hyprlock.settings = {
    background = [
      {
        monitor = "eDP-1";
        path = "~/dotfiles/wallpapers/longwood_gardens_april_2026_1920x1200.jpg";
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
