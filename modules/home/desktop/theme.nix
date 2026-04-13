{ lib, config, ... }:

with lib;
{
  config = mkIf config.dots.enable {
    gtk = {
      # Follow current Home Manager default: keep GTK4 theme unset unless a
      # specific GTK4 theme is intentionally configured.
      gtk4.theme = null;
    };
  };
}
