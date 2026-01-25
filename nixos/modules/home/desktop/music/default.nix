{ lib, config, ... }:

with lib;
let
  cfg = config.desktop.mpd;
in
{
  imports = [
    ./mpd.nix
    ./cava.nix
    ./rmpc.nix
  ];

  options.desktop.mpd = {
    enable = mkEnableOption "mpd";

    client = mkOption {
      type = types.enum [ "rmpc" ];
      default = "rmpc";
      description = "The default mpd client for the DE to use.";
    };

    rmpc.enable = mkEnableOption "rmpc";

    cava.enable = mkOption {
      default = true;
      example = true;
      description = "Whether to enable cava.";
      type = lib.types.bool;
    };
  };

  config = mkIf cfg.enable {
    desktop.mpd.rmpc.enable = mkDefault (cfg.client == "rmpc");

    assertions = [
      {
        assertion = (cfg.client == "rmpc" -> cfg.rmpc.enable);
        message = "desktop.mpd.client is set to 'rmpc', but desktop.mpd.rmpc.enable is false.";
      }
    ];
  };
}
