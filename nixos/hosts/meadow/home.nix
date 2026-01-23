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
}
