{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;

      # Parallelism for builds
      max-jobs = "auto";
      # Use all cores
      cores = 0;

      trusted-users = [
        "root"
        "@wheel"
      ];

      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    gc = {
      # See nh for cleaning
      automatic = false;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.nh = {
    enable = true;
    flake = "/home/jonathan/dotfiles";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  systemd.timers."nh-clean".timerConfig.Persistent = true;
}
