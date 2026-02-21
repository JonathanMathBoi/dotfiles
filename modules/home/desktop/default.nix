{ lib, config, ... }:
with lib;
let
  cfg = config.dots.desktop;
in
{
  imports = [
    ./hyprland.nix
    ./cursor.nix
    ./hyprpaper.nix

    # TODO: Convert lock screen and ilde to module options
    # TODO: Add mobile vs desktop idle options
    ./hypridle.nix
    ./hyprlock.nix

    ./mpris.nix

    # TODO: Switch from waybar to AGS
    ./waybar.nix
    ./dunst.nix

    ./terminals
    ./browsers
    ./music
    ./applications
    ./creative
    ./gaming
    ./launchers
  ];

  options.dots.desktop = {
    enable = mkEnableOption "desktop environment";
  };

  config = mkIf cfg.enable {
    # Help with some apps to run in wayland rather then XWayland
    systemd.user.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # Generate hyprland variables based on options
    xdg.configFile."hypr/nix-vars.conf".text = ''
      $launcher = ${cfg.launcher}
      $terminal = ${cfg.terminal}
      $browser = ${cfg.browser}
    '';
  };
}
