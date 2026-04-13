{
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [
    ./nix-settings.nix
    ./fonts.nix
    ./sops.nix
    ./smartd.nix
    ./btrfs-scrub.nix
  ];

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.fish.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Because I use impermenance on some machines, mutableUsers can lead to erphemeral state headaches
  users.mutableUsers = false;

  users.users.jonathan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "render" # For hardware encoding
    ];
    shell = pkgs.fish;
  }
  // lib.optionalAttrs (!config.users.mutableUsers) {
    hashedPasswordFile = config.sops.secrets."${config.networking.hostName}/jonathan/password".path;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Switched away from referance impl because it causes UWSM race conditions at shutdown
  services.dbus.implementation = "broker";
  programs.dconf.enable = true;

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        (action.id == "org.freedesktop.login1.reboot" ||
         action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
         action.id == "org.freedesktop.login1.power-off" ||
         action.id == "org.freedesktop.login1.power-off-multiple-sessions") &&
        subject.isInGroup("wheel")
      ) {
        return polkit.Result.YES;
      }
    });
  '';

  # To make ghostty pleasant on headless
  environment.systemPackages = [
    pkgs.ghostty.terminfo
  ];
}
