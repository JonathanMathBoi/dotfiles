{ config, pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr/hyprland.conf";

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    grimblast
  ];
}
