{
  pkgs,
  zmk-nix,
  system,
}:

let
  source = pkgs.lib.sourceFilesBySuffices ./. [
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

  zmkSource = pkgs.runCommand "lily58-zmk-source" { } ''
    mkdir -p $out/config
    cp -r ${source}/* $out/
    cp ${../common/homerow_mods.dtsi} $out/config/homerow_mods.dtsi
  '';

  firmware = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
    name = "lily58-firmware";

    src = zmkSource;

    board = "nice_nano@2.0.0//zmk";
    shield = "lily58_%PART% nice_view_adapter nice_view";

    enableZmkStudio = true;

    zephyrDepsHash = "sha256-gXzT6Q60qsThjPtJOiWkAa+sUsf2/Lpilvw5Plvxgxo=";

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
