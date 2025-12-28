{ ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
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
