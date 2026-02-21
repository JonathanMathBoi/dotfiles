{ ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/desktop
  ];

  dots.desktop = {
    enable = true;
    "form-factor" = "mobile";
    mpd.enable = true;

    xournalpp.enable = true;

    creative = {
      enable = true;
      krita.enable = true;
    };
  };

  programs.git.signing.key = "E44941267E6C7C82";

  xdg.configFile."hypr/monitors.conf".text = ''
    monitor=eDP-1, 1920x1280@60, 0x0, 1.25
  '';

  services.hyprpaper.settings = {
    preload = [ "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg" ];
    wallpaper = [
      {
        monitor = "eDP-1";
        path = "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg";
      }
    ];
  };

  programs.hyprlock.settings = {
    background = [
      {
        monitor = "eDP-1";
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

  # Makes sure MPD can get to music library
  systemd.user.services.mpd.Service.RequiresMountsFor = "/home/jonathan/music";
}
