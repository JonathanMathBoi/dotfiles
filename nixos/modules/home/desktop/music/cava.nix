{ ... }:

{
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
}
