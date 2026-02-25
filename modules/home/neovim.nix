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
      vscode-langservers-extracted # Provides cssls, jsonls, and html useful for various configs
      nixd

      # Formatters
      stylua
      prettierd
      nixfmt

      # Telescope Live Grep
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [
        p.lua
        p.javascript
        p.css
        p.json
        p.html
        p.embedded_template
        p.nix
        p.rust
        p.java
        p.cpp
        p.llvm
        p.toml
        p.python
      ]))
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";

  # Disable Nix/Home Manager managed catppuccin theme for nvim since I already manage it myself
  catppuccin.nvim.enable = false;
}
