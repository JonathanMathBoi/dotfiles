{
  config,
  lib,
  osConfig,
  ...
}:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf cfg.brave.enable {
    # TODO: Add Brave Origin option and switch to Origin
    programs.brave = {
      enable = true;
      commandLineArgs = [
        # BUG: Surface Stylus crashes on Wayland when stylus and then touchpad
        # Submitt bug report and switch back to Wayland as soon as possible
        "--ozone-platform=x11"
      ];
    };
  };
}
