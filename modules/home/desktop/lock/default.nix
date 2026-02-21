{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  imports = [
    ./hyprlock.nix
  ];

  options.dots.desktop = {
    lock = mkOption {
      type = types.enum [ "hyprlock" ];
      default = "hyprlock";
      description = "The lock screen for the DE to use.";
    };

    hyprlock.enable = mkEnableOption "hyprlock";
  };

  config = mkIf cfg.enable {
    dots.desktop.hyprlock.enable = mkDefault (cfg.lock == "hyprlock");

    assertions = [
      {
        assertion = (cfg.lock == "hyprlock" -> cfg.hyprlock.enable);
        message = "desktop.lock is set to 'hyprlock', but desktop.hyprlock.enable is false.";
      }
    ];
  };
}
