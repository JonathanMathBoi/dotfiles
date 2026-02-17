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
    hashedPasswordFile = "/etc/secrets/jonathan-password";
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    shell = pkgs.fish;
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
