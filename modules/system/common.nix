{ pkgs, ... }:

{
  imports = [
    ./nix-settings.nix
    ./fonts.nix
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
    ];
    shell = pkgs.fish;

    # TODO: Switch to sops-nix for passwords
    # Make sure to use seperate passwords for each host, since that's what storing on host currently
    # does
    hashedPasswordFile = "/etc/secrets/jonathan-password";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Switched away from referance impl because it causes UWSM race conditions at shutdown
  services.dbus.implementation = "broker";

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
}
