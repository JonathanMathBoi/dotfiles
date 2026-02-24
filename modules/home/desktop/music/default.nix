{ lib, config, ... }:

with lib // (import ../../../lib.nix { inherit lib; });
let
  cfg = config.dots.desktop.mpd;
in
{
  imports = [
    ./mpd.nix
    ./cava.nix
    ./rmpc.nix
  ];

  options.dots.desktop.mpd = {
    enable = mkEnableOption "mpd";

    client = mkOption {
      type = types.enum [ "rmpc" ];
      default = "rmpc";
      description = "The default mpd client for the DE to use.";
    };

    rmpc.enable = mkGatedEnable cfg "rmpc";

    cava.enable = mkGatedEnable cfg "cava" // {
      default = true;
    };
  };

  config = mkIf cfg.enable {
    dots.desktop.mpd.rmpc.enable = mkDefault (cfg.client == "rmpc");

    assertions = [
      {
        assertion = (cfg.client == "rmpc" -> cfg.rmpc.enable);
        message = "desktop.mpd.client is set to 'rmpc', but desktop.mpd.rmpc.enable is false.";
      }
    ];
  };
}
