{
  config,
  inputs,
  pkgs,
  ...
}:

{
  systemd.user.sessionVariables = {
    HYPRLAND_CONFIG = "${config.home.homeDirectory}/dotfiles/hypr/hyprland.lua";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    # Use the development version of Hyprland
    # FIX: Bug in latest git hyprland breaks live rotation
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage =
    #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.hyprpolkitagent.enable = true;

  home.file.".local/share/hypr/stubs" = {
    # FIX: Bug in latest git hyprland breaks live rotation
    # source = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/share/hypr/stubs";
    source = "${pkgs.hyprland}/share/hypr/stubs";
    recursive = true;
  };

  home.packages = with pkgs; [
    wl-clipboard
    grimblast
  ];
}
