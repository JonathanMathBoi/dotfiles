{
  config,
  inputs,
  pkgs,
  ...
}:

{
  systemd.user.sessionVariables = {
    HYPRLAND_CONFIG = "${config.dots.repoPath}/hypr/hyprland.lua";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    # Use the development version of Hyprland
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.hyprpolkitagent.enable = true;

  home.file.".local/share/hypr/stubs" = {
    source = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/share/hypr/stubs";
    recursive = true;
  };

  home.packages = with pkgs; [
    wl-clipboard
    grimblast
  ];
}
