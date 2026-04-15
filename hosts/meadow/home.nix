{ pkgs, ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home
    ./framework-12/home.nix
  ];

  dots = {
    enable = true;

    desktop = {
      enable = true;
      formFactor = "mobile";
      mpd.enable = true;

      xournalpp.enable = true;

      creative = {
        enable = true;
        krita.enable = true;
      };
    };
  };

  programs.git.signing.key = "E44941267E6C7C82";

  home.packages = with pkgs; [ iio-hyprland ];

  systemd.user.services.iio-hyprland = {
    Unit = {
      Description = "Auto-rotate Hyprland monitors from IIO sensors";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.iio-hyprland}/bin/iio-hyprland";
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Makes sure MPD can get to music library
  systemd.user.services.mpd.Service.RequiresMountsFor = "/home/jonathan/music";
}
