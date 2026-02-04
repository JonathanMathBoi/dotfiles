{ config, lib, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.brave.enable) {
    programs.brave = {
      enable = true;
      commandLineArgs = [
        # BUG: Surface Stylus crashes on Wayland when stylus and then touchpad
        # Submitt bug report and switch back to Wayland as soon as possible
        "--ozone-platform=x11"
        # BUG: Make 1.25x scaling only apply to meadow
        "--force-device-scale-factor=1.25"
      ];
    };
  };
}
