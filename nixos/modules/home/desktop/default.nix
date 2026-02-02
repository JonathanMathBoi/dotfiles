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
    ./hypridle.nix
    ./hyprlock.nix
    ./mpris.nix

    ./launchers

    # TODO: Switch from waybar to AGS
    ./waybar.nix
    ./dunst.nix

    ./terminals
    ./browsers
    ./music
    ./applications
    ./creative
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
