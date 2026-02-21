{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  imports = [
    ./hypridle.nix
  ];

  options.dots.desktop = {
    idle = mkOption {
      type = types.enum [ "hypridle" ];
      default = "hypridle";
      description = "The idle daemon for the DE to use.";
    };

    hypridle.enable = mkEnableOption "hypridle";
  };

  config = mkIf cfg.enable {
    dots.desktop.hypridle.enable = mkDefault (cfg.idle == "hypridle");

    assertions = [
      {
        assertion = (cfg.idle == "hypridle" -> cfg.hypridle.enable);
        message = "desktop.idle is set to 'hypridle', but desktop.hypridle.enable is false.";
      }
    ];
  };
}
