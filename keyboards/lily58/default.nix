{
  pkgs,
  zmk-nix,
  system,
}:

let
  firmware = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
    name = "lily58-firmware";

    src = pkgs.lib.sourceFilesBySuffices ./. [
      ".board"
      ".cmake"
      ".conf"
      ".defconfig"
      ".dts"
      ".dtsi"
      ".json"
      ".keymap"
      ".overlay"
      ".shield"
      ".yml"
      "_defconfig"
    ];

    board = "nice_nano_v2";
    shield = "lily58_%PART% nice_view_adapter nice_view";

    enableZmkStudio = true;

    # Placeholder: run `nix build .#lily58` once, copy the "got:" hash from
    # the mismatch error, and replace this value with the correct hash.
    zephyrDepsHash = "sha256-gsqiTDJLAihVyBXVFlgXwqRmlREcFJctKpl4tEWmVlY=";

    meta = {
      description = "ZMK firmware for Lily58 Pro with nice!view screens";
      license = pkgs.lib.licenses.mit;
      platforms = pkgs.lib.platforms.all;
    };
  };
in
pkgs.runCommand "lily58-firmware" { } ''
  mkdir $out
  ln -s ${firmware}/zmk_left.uf2 $out/lily58_left.uf2
  ln -s ${firmware}/zmk_right.uf2 $out/lily58_right.uf2
''
