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
  config = mkIf (cfg.enable && cfg.brave.enable) {
    programs.brave = {
      enable = true;
      commandLineArgs = [
        # BUG: Surface Stylus crashes on Wayland when stylus and then touchpad
        # Submitt bug report and switch back to Wayland as soon as possible
        "--ozone-platform=x11"
      ]
      # HACK: Make Brave use 1.25 scale on meadow because of XWayland being needed for stylus crash prevention
      ++ optional (osConfig.networking.hostName == "meadow") "--force-device-scale-factor=1.25";
    };
  };
}
