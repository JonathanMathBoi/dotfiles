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

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
