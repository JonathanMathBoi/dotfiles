{ config, lib, ... }:

let
  cfg = config.desktop;
in
{
  config = lib.mkIf (cfg.enable && cfg.browser == "brave") {
    programs.brave.enable = true;
  };
}
