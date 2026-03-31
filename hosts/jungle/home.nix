{ ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home
  ];

  dots.enable = true;

  programs.git.signing.key = "8D216E5BA2708CD8";
}
