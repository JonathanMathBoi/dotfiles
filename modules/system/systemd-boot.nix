{ ... }:

{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;

      edk2-uefi-shell.enable = true;
    };

    efi.canTouchEfiVariables = true;
  };
}
