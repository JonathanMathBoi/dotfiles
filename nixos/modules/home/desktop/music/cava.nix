{ config, lib, ... }:

with lib;
let
  cfg = config.desktop.mpd;
in
{
  config = mkIf (cfg.enable && cfg.cava.enable) {
    programs.cava = {
      enable = true;
      settings = {
        input.method = "fifo";
        input.source = "/tmp/mpd.fifo";
      };
    };

    catppuccin.cava = {
      enable = true;
      transparent = true;
    };
  };
}
