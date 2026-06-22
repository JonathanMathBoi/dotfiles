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
      ssh = {
        body = ''
          function ssh
              if set -q TMUX
                  # We are inside tmux. Tell Ghostty to open a new window running raw SSH.
                  # This completely avoids local tmux nesting.
                  ghostty -e "ssh $argv"
              else
                  # We aren't in tmux (or are running a raw command), run ssh normally.
                  command ssh $argv
              end
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
