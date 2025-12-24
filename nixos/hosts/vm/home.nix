{ ... }:

{
  # This value determines the Home Manager release that the configuration is compatible with.
  home.stateVersion = "25.11";

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/desktop/common.nix
  ];

  programs.git.signing.key = "8D216E5BA2708CD8";

  xdg.configFile."hypr/monitors.conf".text = ''
    # Set the monitor to match the ultrawide
    monitor = Virtual-1, 3440x1440@60, 0x0, 1

    # Start the SPICE agent for smoothness
    exec-once = spice-vdagent
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
