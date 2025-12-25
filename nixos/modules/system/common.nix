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

  users.users.jonathan = {
    isNormalUser = true;
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
}
