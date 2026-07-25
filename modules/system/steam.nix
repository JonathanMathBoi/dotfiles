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

  # TODO: Consider moving outside of steam since more than just Steam games use controllers
  hardware.steam-hardware.enable = true;
  boot.kernelModules = [ "uinput" ];
  users.users.jonathan.extraGroups = [
    "input"
    "uinput"
  ];

  programs.gamescope.enable = true;
}
