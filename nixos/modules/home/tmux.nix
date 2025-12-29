{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = catppuccin;
        extraConfig = "set -g @catppuccin_flavour 'macchiato'";
      }
    ];

    extraConfig = ''
      # Make sure full color works on all terminals
      set -as terminal-overrides ",*:Tc"

      # Renumber windows when one closes
      set -g renumber-windows on
    '';
  };
}
