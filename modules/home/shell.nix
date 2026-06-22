{ ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if status is-interactive
          and not set -q TMUX
          # Attach to an existing session named "main", or create it if it doesn't exist
          exec tmux new-session -A -s main
      end

      set -gx GPG_TTY (tty)
    '';

    functions = {
      shutdown = {
        body = ''
          read -p "echo 'Shutdown the system? (y/N): '" -l confirm
          if test "$confirm" = "y" -o "$confirm" = "Y"
              systemctl poweroff
          else
              echo "Aborted."
          end
        '';
      };
      reboot = {
        body = ''
          read -p "echo 'Reboot the system? (y/N): '" -l confirm
          if test "$confirm" = "y" -o "$confirm" = "Y"
              systemctl reboot
          else
              echo "Aborted."
          end
        '';
      };
      rsh = {
        description = "Open new terminal sshed in to args";
        body = ''
          if set -q TMUX
              env WAYLAND_DISPLAY=$WAYLAND_DISPLAY DISPLAY=$DISPLAY ghostty -e ssh $argv >/dev/null 2>&1 &
              disown
          else
              # We aren't in tmux (or are running a raw command), run ssh normally.
              command ssh $argv
          end
        '';
      };
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };
}
