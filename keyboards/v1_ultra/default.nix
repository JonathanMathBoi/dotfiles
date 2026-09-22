{
  zmk-nix,
  system,
  lib,
}:

zmk-nix.legacyPackages.${system}.buildKeyboard {
  name = "keychron-v1-ultra-firmware";

  src = ./.;

  board = "keychron";
  shield = "keychron_v1_ultra_ansi";

  config = "config";

  zephyrDepsHash = "sha256-cImuZChGyuEpohnf8qWObJhTyQK39XelUw5VO9ZMXoM=";

  # Keychron's fork assumes an in-tree build and ships its post-build helper
  # without executable permissions, so adapt the zmk-nix out-of-tree build.
  postConfigure = ''
    chmod +x ../zmk/app/tools/prepend_header/linux-x86_64/prepend_header
    ln -s zephyr.bin ../build/zephyr/zmk.bin
    ln -s ../../build ../zmk/app/build
  '';

  installPhase = ''
    mkdir $out
    cp ../build/zephyr/zephyr.bin $out/keychron_v1_ultra.bin
  '';
}
