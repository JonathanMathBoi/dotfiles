{ ... }:

{
  services.udev.extraRules = ''
    # Keychron USB Vendor ID (0x3434) - allow user access to raw HID
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", MODE="0660", TAG+="uaccess"

    # Realtek Bootloader / DFU mode (Vendor ID 0x0bda)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bda", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", MODE="0660", TAG+="uaccess"
  '';
}
