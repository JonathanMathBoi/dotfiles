{ ... }:

{
  programs.alvr = {
    # BUG: Failing to build. Temporarilly disabling
    enable = true;
    openFirewall = true;
  };
}
