{ inputs, lib, pkgs, ... }:

let
  # Read the plugin list directly from lazy-lock.json so this stays in sync
  # automatically whenever plugins are added or removed.
  lockFile = builtins.fromJSON (builtins.readFile ../../nvim/lazy-lock.json);

  # Normalize a Lazy directory name to the nixpkgs vimPlugins attribute name.
  # Convention: replace '.' with '-' and lowercase.
  # A small override table handles the handful of plugins whose nixpkgs name
  # differs from what normalization produces.
  nameOverrides = {
    "catppuccin" = "catppuccin-nvim";
  };

  toNixName = name:
    if nameOverrides ? ${name}
    then nameOverrides.${name}
    else lib.replaceStrings [ "." ] [ "-" ] (lib.toLower name);

  # Build the map of lazy-dir-name → store-path, silently skipping any plugin
  # that isn't packaged in nixpkgs (it will fall back to Lazy's normal install).
  lazyPlugins = lib.filterAttrs (_: v: v != null) (
    lib.mapAttrs (name: _:
      let nixName = toNixName name;
      in if pkgs.vimPlugins ? ${nixName} then pkgs.vimPlugins.${nixName} else null
    ) lockFile
  );
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
