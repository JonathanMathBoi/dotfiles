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
    ];

    extraConfig = ''
      # Make sure full color works on all terminals
      set -as terminal-overrides ",*:Tc"

      # Renumber windows when one closes
      set -g renumber-windows on
    '';
  };

  # Explicitly turning on catppuccin theme for tmux
  catppuccin.tmux.enable = true;
}
