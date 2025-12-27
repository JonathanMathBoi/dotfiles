{ ... }:

{
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
