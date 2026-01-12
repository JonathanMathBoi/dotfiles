{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.jonathan.openssh.authorizedKeys.keys = [
    # forest SSH Key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqSqi1V2EM1QpILBwYK6+nmhCM9QfGf5NFEB28AGkut jonathan@forest"

    # meadow SSH Key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC79QLv61fTw1BXbnlJwJ8ccve7nydpA4c1Uxzn8nzS6slcLK4NP98FNVWyyGB1Avd7Mif+EzmXRx+AoGJimjQOPFNQi7ERt3jwRkB4gex5tLNcyD3trJ92Nuw/DsHj0jgW++C40lc34d0KWj+y5XrzPwTz72YDJxvG8E2pnsmGRg/xJ+SwGOw9ifMoZyAQgUvJEN/jGSBCYYf+PVF8imLtix3/c3qRGH63uoWKwGN9LLWqLcxTkBXTHbA2l/lH74yL5vBbbVM/ETotOosQe+Dbmk49mgcF4D9x8rmJfUz/MxxdoGTzylCG9xqJZ0DDIHNhkLipgASXXvHYL0/OgPxik//3za6f+mA7nIAW0Wab2R+qhET5um5yTTp2wuLSqsLSAs9Cw+QisZChmzcJCoxevG1lE8OuJGN98/M6V3dWQsZs20AMX3OA3G7pdlV+h9kW6rvYGKa0Ri1j/zOP4usOcXDmHvfgiI6+0dtoPSD2VP4/ld6XRpV5arBIxFmbALM= hartj@meadow"
  ];
}
