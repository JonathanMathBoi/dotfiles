#!/usr/bin/env fish

set -e

set -l top_mnt "/mnt/meadow-btrfs-top"
set -l persist_mnt "/mnt/meadow-persist"

set -l dirs_to_copy \
  "var/log" \
  "var/db/sudo" \
  "var/lib/bluetooth" \
  "var/lib/nixos" \
  "var/lib/tailscale" \
  "var/lib/systemd/coredump" \
  "var/lib/systemd/timers" \
  "etc/NetworkManager/system-connections" \
  "var/cache/tuigreet"

set -l files_to_copy \
  "etc/machine-id" \
  "etc/ssh/ssh_host_ed25519_key" \
  "etc/ssh/ssh_host_ed25519_key.pub" \
  "etc/ssh/ssh_host_rsa_key" \
  "etc/ssh/ssh_host_rsa_key.pub"

function usage
  echo "Usage: hosts/meadow/impermanence-setup.sh [--dry-run] [--root-device <path>]"
  echo
  echo "Creates @persist and copies meadow persisted paths into it."
end

argparse 'n/dry-run' 'r/root-device=' 'h/help' -- $argv
or begin
  usage
  exit 1
end

if set -q _flag_help
  usage
  exit 0
end

set -l dry_run 0
if set -q _flag_dry_run
  set dry_run 1
end

function log
  echo "[impermanence-setup] $argv"
end

function run_cmd --argument-names dry_flag
  set -e argv[1]
  if test "$dry_flag" -eq 1
    echo "[dry-run] "(string join " " -- $argv)
  else
    $argv
  end
end

function cleanup --on-process-exit %self
  if mountpoint -q "$persist_mnt"
    umount "$persist_mnt"
  end
  if mountpoint -q "$top_mnt"
    umount "$top_mnt"
  end
end

if test (id -u) -ne 0
  echo "Run this script as root." >&2
  exit 1
end

for cmd in btrfs findmnt mount mountpoint rsync umount
  if not type -q "$cmd"
    echo "Missing required command: $cmd" >&2
    exit 1
  end
end

set -l device ""
if set -q _flag_root_device
  set device "$_flag_root_device"
else
  set device (findmnt -n -o SOURCE /)
end

if test -z "$device"
  echo "Unable to detect root source. Pass --root-device." >&2
  exit 1
end

log "Using root source: $device"
if test "$dry_run" -eq 1
  log "Dry run enabled"
end

mkdir -p "$top_mnt" "$persist_mnt"

run_cmd "$dry_run" mount -t btrfs -o subvolid=5 "$device" "$top_mnt"

if not test -d "$top_mnt/@persist"
  run_cmd "$dry_run" btrfs subvolume create "$top_mnt/@persist"
else
  log "@persist already exists"
end

run_cmd "$dry_run" mount -t btrfs -o subvol=@persist "$device" "$persist_mnt"

set -l rsync_opts -aAXH --numeric-ids --relative
if test "$dry_run" -eq 1
  set rsync_opts $rsync_opts -n -v
end

for path in $dirs_to_copy
  if test -e "/$path"
    run_cmd "$dry_run" rsync $rsync_opts "/$path" "$persist_mnt/"
  else
    log "Skipping missing directory: /$path"
  end
end

for path in $files_to_copy
  if test -e "/$path"
    run_cmd "$dry_run" rsync $rsync_opts "/$path" "$persist_mnt/"
  else
    log "Skipping missing file: /$path"
  end
end

if test "$dry_run" -eq 0
  if test -f "$persist_mnt/etc/ssh/ssh_host_ed25519_key"
    chmod 600 "$persist_mnt/etc/ssh/ssh_host_ed25519_key"
    chown root:root "$persist_mnt/etc/ssh/ssh_host_ed25519_key"
  end
  if test -f "$persist_mnt/etc/ssh/ssh_host_rsa_key"
    chmod 600 "$persist_mnt/etc/ssh/ssh_host_rsa_key"
    chown root:root "$persist_mnt/etc/ssh/ssh_host_rsa_key"
  end
  if test -f "$persist_mnt/etc/ssh/ssh_host_ed25519_key.pub"
    chmod 644 "$persist_mnt/etc/ssh/ssh_host_ed25519_key.pub"
    chown root:root "$persist_mnt/etc/ssh/ssh_host_ed25519_key.pub"
  end
  if test -f "$persist_mnt/etc/ssh/ssh_host_rsa_key.pub"
    chmod 644 "$persist_mnt/etc/ssh/ssh_host_rsa_key.pub"
    chown root:root "$persist_mnt/etc/ssh/ssh_host_rsa_key.pub"
  end
end

log "Done. Next: nixos-rebuild switch --flake .#meadow, then reboot."
