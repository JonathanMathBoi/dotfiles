{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
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

      # Telescope Live Grep
      ripgrep
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
}
