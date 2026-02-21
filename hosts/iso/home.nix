{ inputs, lib, pkgs, ... }:

let
  # Maps each lazy.nvim plugin directory name (from lazy-lock.json) to the
  # corresponding nixpkgs vimPlugin. These are copied into
  # ~/.local/share/nvim/lazy/ at activation time so that lazy sees all
  # plugins as already installed — no network required, no janky first-run.
  lazyPlugins = {
    "lazy.nvim"               = pkgs.vimPlugins.lazy-nvim;
    "LuaSnip"                 = pkgs.vimPlugins.luasnip;
    "catppuccin"              = pkgs.vimPlugins.catppuccin-nvim;
    "cmp-buffer"              = pkgs.vimPlugins.cmp-buffer;
    "cmp-nvim-lsp"            = pkgs.vimPlugins.cmp-nvim-lsp;
    "cmp-path"                = pkgs.vimPlugins.cmp-path;
    "cmp_luasnip"             = pkgs.vimPlugins.cmp_luasnip;
    "conform.nvim"            = pkgs.vimPlugins.conform-nvim;
    "gitsigns.nvim"           = pkgs.vimPlugins.gitsigns-nvim;
    "harpoon"                 = pkgs.vimPlugins.harpoon;
    "lualine.nvim"            = pkgs.vimPlugins.lualine-nvim;
    "mason-lspconfig.nvim"    = pkgs.vimPlugins.mason-lspconfig-nvim;
    "mason.nvim"              = pkgs.vimPlugins.mason-nvim;
    "nvim-autopairs"          = pkgs.vimPlugins.nvim-autopairs;
    "nvim-cmp"                = pkgs.vimPlugins.nvim-cmp;
    "nvim-lspconfig"          = pkgs.vimPlugins.nvim-lspconfig;
    "nvim-surround"           = pkgs.vimPlugins.nvim-surround;
    "nvim-treesitter"         = pkgs.vimPlugins.nvim-treesitter;
    "nvim-web-devicons"       = pkgs.vimPlugins.nvim-web-devicons;
    "oil.nvim"                = pkgs.vimPlugins.oil-nvim;
    "plenary.nvim"            = pkgs.vimPlugins.plenary-nvim;
    "rainbow-delimiters.nvim" = pkgs.vimPlugins.rainbow-delimiters-nvim;
    "telescope.nvim"          = pkgs.vimPlugins.telescope-nvim;
    "todo-comments.nvim"      = pkgs.vimPlugins.todo-comments-nvim;
    "trouble.nvim"            = pkgs.vimPlugins.trouble-nvim;
    "vim-fugitive"            = pkgs.vimPlugins.vim-fugitive;
    "which-key.nvim"          = pkgs.vimPlugins.which-key-nvim;
  };
in

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/desktop
  ];

  # Copy dotfiles to ~/dotfiles as a writable directory so that tools like
  # lazy.nvim can write lock files into the config tree, replicating how
  # a real machine has a writable git clone at ~/dotfiles.
  # All lazy.nvim plugins are also copied from nixpkgs so that the first nvim
  # launch is clean — no install step, no network needed.
  home.activation.setupDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD rm -rf $HOME/dotfiles
    $DRY_RUN_CMD cp -rT --no-preserve=mode ${inputs.self} $HOME/dotfiles

    lazybase="$HOME/.local/share/nvim/lazy"
    $DRY_RUN_CMD mkdir -p "$lazybase"
    ${lib.concatMapStrings (name: ''
      $DRY_RUN_CMD rm -rf "$lazybase/${name}"
      $DRY_RUN_CMD cp -rT --no-preserve=mode ${lazyPlugins.${name}} "$lazybase/${name}"
    '') (builtins.attrNames lazyPlugins)}
  '';

  dots.desktop = {
    enable = true;
    gaming.enable = false;
    creative.enable = false;
  };

  # Generic monitor config — let Hyprland pick the best mode automatically
  xdg.configFile."hypr/monitors.conf".text = ''
    monitor=,preferred,auto,1
  '';

  services.hyprpaper.settings = {
    preload = [ "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg" ];
    wallpaper = [
      {
        monitor = "";
        path = "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg";
      }
    ];
  };

  programs.hyprlock.settings = {
    background = [
      {
        path = "~/dotfiles/wallpapers/longwood_gardens_nov_2025_1920x1200.jpg";
        blur_size = 4;
        blur_passes = 3;
        noise = 0.0117;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      }
    ];
  };
}
