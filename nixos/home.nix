{ config, pkgs, ... }:

{
  home.username = "jonathan";
  home.homeDirectory = "/home/jonathan";

  # This value determines the Home Manager release that the configuration is compatible with.
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # LSPs
    lua-language-server
    typescript-language-server # Provides ts_ls
    vscode-langservers-extracted # Provides cssls, jsonls, and html
    emmet-ls
    nixd

    # Formatters
    stylua
    prettierd
    nixfmt-rfc-style

    # Terminal tools
    yazi
    tmux
    ripgrep
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx GPG_TTY (tty)
    '';
    shellAliases = {
      mus = "ncmpcpp -q";
    };
    functions = {
      ya = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
              cd "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.bat = {
    enable = true;
    # TODO: Theme with catppuccin
  };

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

  home.sessionVariables = {
    # Use bat for coloring man pages
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim";

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
