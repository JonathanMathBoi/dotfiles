{ ... }:

{
  services.smartd = {
    enable = true;
    autodetect = true;

    notifications = {
      wall.enable = false;
      mail.enable = false;
    };

    # Monitor all SMART attributes, avoid spinning up sleeping disks, run
    # daily short tests and weekly long tests.
    defaults.monitored = "-a -o on -S on -n standby,q -s (S/../.././03|L/../../7/04)";
  };
}
