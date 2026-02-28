{ lib, config, ... }:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop;
in
{
  imports = [
    ./brave.nix
  ];

  options.dots.desktop = {
    browser = mkOption {
      type = types.enum [ "brave" ];
      default = "brave";
      description = "The default browser.";
    };

    brave.enable = mkGatedEnable cfg "brave";
  };

  config = mkIf cfg.enable {
    dots.desktop.brave.enable = mkDefault (cfg.browser == "brave");

    assertions = [
      {
        assertion = (cfg.browser == "brave" -> cfg.brave.enable);
        message = "desktop.browser is set to 'brave', but desktop.brave.enable is false.";
      }
    ];
  };
}
