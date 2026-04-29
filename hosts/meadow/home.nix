{ ... }:

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
}
