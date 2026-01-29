{ lib, config, ... }:
with lib;
let
  cfg = config.desktop;
in
{
  imports = [
    ./hyprland.nix
    ./cursor.nix
    ./hyprpaper.nix
    ./hyprlauncher.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./mpris.nix

    # TODO: Switch from waybar to AGS
    ./waybar.nix
    ./dunst.nix

    ./brave.nix

    ./terminals
    ./music
    ./applications
  ];

  options.desktop = {
    enable = mkEnableOption "desktop environment";

    browser = mkOption {
      type = types.enum [ "brave" ];
      default = "brave";
      description = "The default browser";
    };
  };

  config = mkIf cfg.enable {
    # Help with some apps to run in wayland rather then XWayland
    systemd.user.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # Generate hyprland variables based on options
    xdg.configFile."hypr/nix-vars.conf".text = ''
      $terminal = ${cfg.terminal}
      $browser = ${cfg.browser}
    '';
  };
}
