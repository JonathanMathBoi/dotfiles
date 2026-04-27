{ ... }:

{
  programs.alvr = {
    # BUG: Failing to build. Temporarilly disabling
    enable = false;
    openFirewall = true;
  };
}
