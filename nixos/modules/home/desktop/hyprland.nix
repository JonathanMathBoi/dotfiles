{ config, pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/hypr/hyprland.conf";

  home.packages = with pkgs; [ wl-clipboard ];
}
