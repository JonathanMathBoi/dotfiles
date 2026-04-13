{ config, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    # Follow current Home Manager default to avoid exporting XDG_*_DIR vars
    # into the session unless explicitly needed by legacy scripts.
    setSessionVariables = false;

    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    videos = "${config.home.homeDirectory}/videos";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/templates";
  };
}
