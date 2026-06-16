{ ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    # Enabled so that Steam Controller cursor handeling works right
    extest.enable = true;
  };

  programs.gamescope.enable = true;
}
