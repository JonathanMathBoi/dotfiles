{ pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.conf".source = ../../../hypr/hyprland.conf;

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    grimblast
  ];
}
