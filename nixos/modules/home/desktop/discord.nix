{ ... }:

{
  programs.discord.enable = true;

  xdg.desktopEntries.discord = {
    name = "Discord";
    # Force Discord to run natively on Wayland
    exec = "discord --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
    icon = "discord";
    genericName = "All-in-one voice and text chat";
    categories = [
      "Network"
      "InstantMessaging"
    ];
    terminal = false;
    mimeType = [ "x-scheme-handler/discord" ];
  };
}
