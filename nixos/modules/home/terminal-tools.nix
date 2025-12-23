{ ... }:

{
  programs.bat = {
    enable = true;
    # TODO: Theme with catppuccin
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "ya";
    enableFishIntegration = true;
  };

  home.sessionVariables = {
    # Use bat for coloring man pages
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
