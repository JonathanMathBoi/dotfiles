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

    ./alacritty.nix
    ./brave.nix
    ./discord.nix
  ];

  options.desktop = {
    enable = mkEnableOption "desktop environment";

    terminal = mkOption {
      type = types.enum [ "alacritty" ];
      default = "alacritty";
      description = "The main terminal emulator for the DE to use.";
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
    '';
  };
}
