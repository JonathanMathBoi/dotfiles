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

  # HACK: Clean up Calibre installation into home manager module
  home.packages = with pkgs; [
    calibre
    openssl
  ];

  programs.git.signing.key = "E44941267E6C7C82";
}
