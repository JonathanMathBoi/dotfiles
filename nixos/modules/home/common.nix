{ ... }:

{
  home.username = "jonathan";
  home.homeDirectory = "/home/jonathan";
  home.language.base = "en_US.UTF-8";

  imports = [
    ./shell.nix
    ./git.nix
    ./neovim.nix
    ./terminal-tools.nix
    ./tmux.nix
    ./fastfetch.nix
  ];
}
