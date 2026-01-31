{ ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/desktop
    ../../modules/home/desktop/mangohud.nix
  ];

  dots.desktop = {
    enable = true;
    mpd.enable = true;
  };

  programs.git.signing.key = "8D216E5BA2708CD8";

  xdg.configFile."hypr/monitors.conf".text = ''
    # Ultrawide only has VRR in fullscreen to prevent desktop flickering
    monitor=DP-5,3440x1440@144,0x0,1,vrr,0
    monitor=DP-3,2560x1440@100,3440x0,1
  '';

  services.hyprpaper.settings = {
    preload = [
      "~/pictures/wallpapers/toon-totk.jpg"
      "~/pictures/wallpapers/forest-b-verse.jpg"
    ];
    wallpaper = [
      {
        monitor = "DP-5";
        path = "~/pictures/wallpapers/toon-totk.jpg";
      }
      {
        monitor = "DP-3";
        path = "pictures/wallpapers/forest-b-verse.jpg";
      }
    ];
  };

  programs.hyprlock.settings = {
    background = [
      {
        monitor = "DP-5";
        path = "~/pictures/wallpapers/toon-totk.png";
        blur_size = 4;
        blur_passes = 3;
        noise = 0.0117;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      }
      {
        monitor = "DP-3";
        path = "~/pictures/wallpapers/forest-b.png";
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

  # Set Steam to use dGPU so that it launches properly
  xdg.desktopEntries.steam = {
    name = "Steam";
    genericName = "Application Manager";
    comment = "Application for managing and playing games on Steam";
    exec = "steam %U";
    icon = "steam";
    terminal = false;
    categories = [
      "Network"
      "FileTransfer"
      "Game"
    ];
    mimeType = [
      "x-scheme-handler/steam"
      "x-scheme-handler/steamlink"
    ];
    settings = {
      PrefersNonDefaultGPU = "true"; # Set to "false" if you want the default GPU
    };
  };
}
