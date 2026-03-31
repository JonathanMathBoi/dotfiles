# Jungle Install Day Runbook

This is the exact install flow for `jungle` using `nixos-anywhere` + `disko`.

## 0) Scope and assumptions

- Target host: `jungle`
- Install method: boot NixOS installer ISO on target, run `nixos-anywhere` from your admin machine
- This will fully wipe and repartition the target disks defined in `hosts/jungle/disko.nix`
- Tailscale auth key is already in `secrets/secrets.yaml` under `api.tailscale`
- SSH host keys are pre-generated on install day and copied with `--extra-files`
- LUKS HDD keyfile is generated and enrolled post-install (manual step)

## 1) Preflight on admin machine

Run from repo root:

```fish
git status --short
nix flake check
nix eval .#nixosConfigurations.jungle.config.networking.hostName
nixos-anywhere --help >/dev/null
disko --help >/dev/null
```

Expected host name output: `"jungle"`.

## 2) Boot target into NixOS installer

On the target machine:

```fish
passwd
ip addr
```

- Set a temporary password for installer user `nixos`
- Note the target IP address on Ethernet

## 3) Generate hardware config first (before nixos-anywhere)

From repo root on your admin machine, generate and write it directly:

```fish
mkdir -p hosts/jungle
ssh nixos@TARGET_IP "sudo nixos-generate-config --no-filesystems --show-hardware-config" > hosts/jungle/hardware-configuration.nix
```

Quick sanity check:

```fish
test -s hosts/jungle/hardware-configuration.nix
```

Then enable the import in `hosts/jungle/configuration.nix`:

- uncomment `./hardware-configuration.nix`

Sanity check locally from repo root:

```fish
nix eval .#nixosConfigurations.jungle.config.system.stateVersion
```

## 4) Build the extra-files payload

This payload seeds two things:

- `/home/jonathan/dotfiles`
- `/persist/etc/ssh/` host keys

### 4.1 Create payload tree

```fish
rm -rf /tmp/jungle-extra-files
mkdir -p /tmp/jungle-extra-files/home/jonathan
mkdir -p /tmp/jungle-extra-files/persist/etc/ssh
```

### 4.2 Copy dotfiles into payload

```fish
rsync -a --delete /home/jonathan/dotfiles/ /tmp/jungle-extra-files/home/jonathan/dotfiles/
```

### 4.3 Generate SSH host keys into payload

```fish
ssh-keygen -t ed25519 -N "" -f /tmp/jungle-extra-files/persist/etc/ssh/ssh_host_ed25519_key
ssh-keygen -t rsa -b 4096 -N "" -f /tmp/jungle-extra-files/persist/etc/ssh/ssh_host_rsa_key
chmod 600 /tmp/jungle-extra-files/persist/etc/ssh/ssh_host_ed25519_key
chmod 600 /tmp/jungle-extra-files/persist/etc/ssh/ssh_host_rsa_key
chmod 644 /tmp/jungle-extra-files/persist/etc/ssh/ssh_host_ed25519_key.pub
chmod 644 /tmp/jungle-extra-files/persist/etc/ssh/ssh_host_rsa_key.pub
```

Do not pre-seed `machine-id`.

## 5) Verify target disks one last time

On the installer shell (target), run:

```fish
lsblk -o NAME,SIZE,TYPE,MODEL,SERIAL,WWN,FSTYPE,MOUNTPOINT
ls -l /dev/disk/by-id/wwn-0x5000c500ebe21402
ls -l /dev/disk/by-id/wwn-0x50014ee26c793ffd
```

Confirm those WWNs are the two blank 4TB drives intended for the NAS pool.

## 6) Run nixos-anywhere install

From admin machine, from repo root:

```fish
set -xg SSHPASS 'INSTALLER_PASSWORD'

nixos-anywhere \
  --env-password \
  --extra-files /tmp/jungle-extra-files \
  --chown /home/jonathan jonathan:users \
  --flake .#jungle \
  --target-host nixos@TARGET_IP
```

Notes:

- `--extra-files` copies into the new root filesystem
- `--chown /home/jonathan jonathan:users` fixes ownership of seeded dotfiles
- This operation is destructive to configured target disks

## 7) First boot checks

After reboot, SSH in:

```fish
ssh jonathan@TARGET_IP
```

If host key mismatch appears from old installs:

```fish
ssh-keygen -R TARGET_IP
```

Then verify:

```fish
hostnamectl
findmnt / /persist /nix /swap /var/lib/docker /home /srv/media /srv/shared /srv/backups
sudo btrfs filesystem show
sudo btrfs filesystem df /srv/media
```

## 8) Post-install LUKS HDD keyfile bootstrap

Generate a keyfile on the host and enroll it into both HDD LUKS containers.

```fish
sudo install -d -m 0700 /persist/etc/luks-keys
sudo dd if=/dev/urandom of=/persist/etc/luks-keys/jungle-hdd.key bs=1 count=64 status=none
sudo chmod 0400 /persist/etc/luks-keys/jungle-hdd.key
sudo chown root:root /persist/etc/luks-keys/jungle-hdd.key
```

Enroll key on each HDD:

```fish
sudo cryptsetup luksAddKey /dev/disk/by-id/wwn-0x5000c500ebe21402 /persist/etc/luks-keys/jungle-hdd.key
sudo cryptsetup luksAddKey /dev/disk/by-id/wwn-0x50014ee26c793ffd /persist/etc/luks-keys/jungle-hdd.key
```

Reboot and verify unlock behavior.

## 9) Service bring-up checks

### 9.1 Tailscale

```fish
systemctl status tailscaled --no-pager
sudo tailscale status
```

### 9.2 Samba

Set Samba passwords once:

```fish
sudo smbpasswd -a jonathan
sudo smbpasswd -a michael
sudo smbpasswd -a christopher
sudo smbpasswd -a lynn
```

Check service:

```fish
systemctl status smbd --no-pager
testparm -s
```

### 9.3 Plex

```fish
systemctl status plex --no-pager
```

Then claim at `http://TARGET_IP:32400/web` and point libraries into `/srv/media/...`.

## 10) Validation checklist (done means install is complete)

- `jungle` boots cleanly
- mount layout matches disko plan
- HDD LUKS keyfile exists at `/persist/etc/luks-keys/jungle-hdd.key`
- `tailscale status` shows node connected
- Samba logins work for all family accounts
- Plex server claimed and library scan succeeds
- smartd active and btrfs scrub timers present

## 11) Optional VM gate before bare metal

Before bare metal day, run a VM test path using `nixos-anywhere --vm-test` with a dedicated vmtest host config (separate from real WWN disk IDs).
