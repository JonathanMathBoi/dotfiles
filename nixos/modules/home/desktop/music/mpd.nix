{ config, lib, ... }:

with lib;
let
  cfg = config.desktop.mpd;
in
{
  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = config.xdg.userDirs.music;
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }

        ${optionalString cfg.cava.enable ''
          audio_output {
            type "fifo"
            name "Visualizer feed"
            path "/tmp/mpd.fifo"
            format "44100:16:2"
          }
        ''}
      '';
    };

    services.mpdris2 = {
      enable = true;
      notifications = true;

      # Set multimediaKeys to false to prevent mpd from hijacking and blocking the signal from going
      # to anyone else
      multimediaKeys = false;
    };
  };
}
