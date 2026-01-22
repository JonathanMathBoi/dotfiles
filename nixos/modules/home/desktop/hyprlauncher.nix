{ ... }:

{
  services.hyprlauncher = {
    enable = true;
    settings = {
      finders = {
        desktop_launch_prefix = "env NIXOS_OZONE_WL=1 uwsm app -- ";
      };
    };
  };
}
