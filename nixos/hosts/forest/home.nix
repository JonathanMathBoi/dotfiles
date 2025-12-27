{ ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/desktop/common.nix
    ../../modules/home/music/common.nix
  ];

  programs.git.signing.key = "8D216E5BA2708CD8";

  xdg.configFile."hypr/monitors.conf".text = ''
    monitor=DP-5,3440x1440@144,0x0,1
    monitor=DP-3,1920x1080@60,3440x360,1
  '';

  xdg.configFile."hypr/hyprlock.conf".source = ../../../hypr/hyprlock.conf;

  services.hyprpaper.settings = {
    preload = [
      "~/pictures/wallpapers/toon-totk.jpg"
      "~/pictures/wallpapers/forest-b-verse.jpg"
    ];
    wallpaper = [
      "DP-5,~/pictures/wallpapers/toon-totk.jpg"
      "DP-3,~/pictures/wallpapers/forest-b-verse.jpg"
    ];
  };
}
