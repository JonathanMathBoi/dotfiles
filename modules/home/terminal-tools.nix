{ ... }:

{
  programs.bat = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "ya";
    enableFishIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      vim_keys = true;
    };
  };

  home.sessionVariables = {
    # Use bat for coloring man pages
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
