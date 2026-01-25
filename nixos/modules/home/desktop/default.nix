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
    ./discord.nix

    ./terminals
  ];

  options.desktop = {
    enable = mkEnableOption "desktop environment";

    terminal = mkOption {
      type = types.enum [
        "alacritty"
        "kitty"
      ];
      default = "alacritty";
      description = "The main terminal emulator for the DE to use.";
    };

    alacritty.enable = mkEnableOption "alacritty";
    kitty.enable = mkEnableOption "kitty";

    browser = mkOption {
      type = types.enum [ "brave" ];
      default = "brave";
      description = "The default browser";
    };
  };

  config = mkIf cfg.enable {
    desktop.alacritty.enable = mkDefault (cfg.terminal == "alacritty");
    desktop.kitty.enable = mkDefault (cfg.terminal == "kitty");

    assertions = [
      {
        assertion = (cfg.terminal == "alacritty" -> cfg.alacritty.enable);
        message = "desktop.terminal is set to 'alacritty', but desktop.alacritty.enable is false.";
      }
      {
        assertion = (cfg.terminal == "kitty" -> cfg.kitty.enable);
        message = "desktop.terminal is set to 'kitty', but desktop.kitty.enable is false.";
      }
    ];

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
