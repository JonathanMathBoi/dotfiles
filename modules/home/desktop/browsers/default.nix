{ lib, config, ... }:

with lib;
let
  cfg = config.dots.desktop;
  dotsLib = import ../../../lib.nix { inherit lib; };
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

    brave.enable = dotsLib.mkGatedEnable cfg "brave";
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
