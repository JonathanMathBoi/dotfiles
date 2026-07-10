{ ... }:

{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../modules/home/core.nix
    ../modules/home/ai
  ];

  dots = {
    enable = true;

    ai = {
      enable = true;
      opencode.enable = true;
    };
  };
}
