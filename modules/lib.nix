{ lib }:

{
  # Creates a boolean enable option that is automatically gated on the parent
  # module's enable. The apply attribute ANDs the declared value with
  # parentCfg.enable so that consumers can write `mkIf cfg.foo.enable` instead
  # of the repetitive `mkIf (cfg.enable && cfg.foo.enable)`.
  #
  # Usage:
  #   let dotsLib = import ../lib.nix { inherit lib; }; in
  #   options.dots.desktop.foo.enable = dotsLib.mkGatedEnable cfg "foo";
  mkGatedEnable =
    parentCfg: description: lib.mkEnableOption description // { apply = v: v && parentCfg.enable; };
}
