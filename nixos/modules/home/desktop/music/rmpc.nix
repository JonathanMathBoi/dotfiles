{ config, lib, ... }:

with lib;
let
  cfg = config.desktop.mpd;
in
{
  config = mkIf (cfg.enable && cfg.rmpc.enable) {
    programs.rmpc = {
      enable = true;
      config = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
          tabs: [
            (
              name: "Queue",
              pane: Split(
                direction: Horizontal,
                panes: [
                  (
                    size: "40%",
                    pane: Split(
                      direction: Vertical,
                      panes: [
                        (
                          size: "3",
                          pane: Pane(Lyrics)
                        ),
                        (
                          size: "100%",
                          pane: Pane(AlbumArt)
                        ),
                      ],
                    ),
                  ),
                  (
                    size: "60%",
                    pane: Split(
                      direction: Vertical,
                      panes: [
                        (
                          size: "70%",
                          pane: Pane(Queue),
                        ),
                        (
                          size: "30%",
                          pane: Pane(Cava),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (
              name: "Directories",
              pane: Pane(Directories),
            ),
            (
              name: "Artists",
              pane: Pane(Artists),
            ),
            (
              name: "Album Artists",
              pane: Pane(AlbumArtists),
            ),
            (
              name: "Albums",
              pane: Pane(Albums),
            ),
            (
              name: "Playlists",
              pane: Pane(Playlists),
            ),
            (
              name: "Search",
              pane: Pane(Search),
            ),
          ],
          cava: (
            input: (
              method: Fifo,
              source: "/tmp/mpd.fifo",
              sample_rate: 44100,
              channels: 2,
              sample_bits: 16,
            ),
          ),
        )
      '';
    };
  };
}
