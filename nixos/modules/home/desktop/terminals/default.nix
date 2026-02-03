{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
  ];

  options.dots.desktop = {
    terminal = mkOption {
      type = types.enum [
        "alacritty"
        "kitty"
        # TODO: Add ghostty
      ];
      default = "alacritty";
      description = "The main terminal emulator for the DE to use.";
    };

    alacritty.enable = mkEnableOption "alacritty";
    kitty.enable = mkEnableOption "kitty";
  };

  config = mkIf cfg.enable {
    dots.desktop.alacritty.enable = mkDefault (cfg.terminal == "alacritty");
    dots.desktop.kitty.enable = mkDefault (cfg.terminal == "kitty");

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
  };
}
