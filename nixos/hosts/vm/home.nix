{ config, pkgs, ... }:

{
  home.username = "jonathan";
  home.homeDirectory = "/home/jonathan";

  # This value determines the Home Manager release that the configuration is compatible with.
  home.stateVersion = "25.11";

  imports = [
    ../../modules/home/common.nix
  ];

  programs.git = {
    enable = true;

    signing = {
      key = "8D216E5BA2708CD8";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Jonathan Hart";
        email = "jonathan.e.hart@outlook.com";
      };

      pull = {
        rebase = true;
        ff = "only";
      };

      merge.ff = false;

      init.defaultBranch = "main";
    };
  };

  programs.gpg.enable = true;

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = catppuccin;
        extraConfig = "set -g @catppuccin_flavour 'macchiato'";
      }
    ];

    extraConfig = ''
      # Make sure full color works on all terminals
      set -as terminal-overrides ",*:Tc"

      # Renumber windows when one closes
      set -g renumber-windows on
    '';
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    videos = "${config.home.homeDirectory}/videos";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/templates";
  };

  home.language.base = "en_US.UTF-8";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
