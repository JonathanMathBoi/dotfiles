{ ... }:

{
  services.hyprlauncher = {
    enable = true;
    settings = {
      finders = {
        desktop_launch_prefix = "uwsm app -- ";
      };
    };
  };
}
