# Agent Guide

## Structure

- This repository is a Nix flake managing multiple architectures (`x86_64-linux` and eventually non-x86 ARM for a Raspberry Pi host). NixOS entrypoints live under `hosts/{iso,forest,meadow,jungle}`; each host's `configuration.nix` imports its hardware/persistence files and shared system modules, while `home.nix` composes `modules/home`.
- Shared NixOS behavior belongs in `modules/system`; shared Home Manager behavior belongs in `modules/home`. Host files should contain hardware- or machine-specific settings.
- The Hyprland Lua configuration, Waybar files, Neovim configuration, and Lily58/ZMK sources live in `hypr/`, `waybar/`, `nvim/`, and `keyboards/lily58/` respectively.

## Commands

- Run the CI-equivalent validation with `nix flake check .`.
- Format Nix and Lua sources with `nix fmt`; the flake's formatter is treefmt using `nixfmt` and Stylua. Nix indentation is two spaces.
- **System Rebuilds:** We use `nh` for system generation management. 
  - To build a host closure without activating it (dry-run): `nh os build . -- --name <host>`
  - To apply a host configuration: `nh os switch . -- --name <host>`
  - *Fallback (No Activation):* `nix build .#nixosConfigurations.<host>.config.system.build.toplevel`
- Build the installer image with `nix build .#iso` or Lily58 left/right firmware with `nix build .#lily58`.

## Gotchas

- **Architecture Traps:** Do not assume `x86_64-linux` globally when writing modules or cross-compiling helper scripts, as an ARM-based Raspberry Pi host profile will be integrated here shortly. Keep packages and modules target-agnostic.
- `flake.lock` pins all inputs. Do not update it incidentally; use `nix flake update` only when intentionally changing dependencies.
- `secrets/secrets.yaml` is SOPS-encrypted and keyed through `.sops.yaml`. Edit it with SOPS, never replace it with plaintext or expose decrypted contents; host secret access depends on the persisted SSH host key under `/persist/etc/ssh/`.
- **ZMK Firmware Fixed-Outputs:** `flake.nix` contains the Lily58 `zephyrDepsHash`. If `nix build .#lily58` reports a fixed-output hash mismatch, replace the declared hash with the `got:` hash from that build output before retrying.
- The `iso` output is installation media with intentionally insecure/passwordless installer SSH settings; do not copy those settings into normal hosts.
- Storage layout and persistence are host-specific (`disko.nix` and `persistence.nix`). Treat changes there as destructive migration work, not ordinary module refactoring.

## Git & Version Control

You are responsible for managing your own version control. Do not wait for user prompts to stage or commit work. Use a "micro-commit" strategy so that if a change breaks the Nix build, we can easily roll back without losing progress.

### Commit Cadence
- **Commit Early and Often:** Commit after every single logical, atomic change. Examples:
  - Added a new home module option.
  - Fixed a single syntax error or formatter warning.
  - Extracted a shared configuration into `modules/system`.
- **Pre-Commit Verification:** Always run `nix flake check .` and `nix fmt` *before* committing. If the check fails, fix the issue before committing.
- **Never pool changes:** Do not combine unrelated changes (e.g., updating a Waybar style and fixing a Neovim Lua error) into a single commit.

### Branch Strategy & Workflow
- **Current Branch:** We are working directly on the `dev` branch. 
- **Branch Safety:** Before starting a new task, ensure you have the latest state. If you are instructed to create a feature branch for a large, destructive, or experimental change (e.g., Disko/Persistence migrations or adding the ARM Raspberry Pi host), do so using `git checkout -b feature/<feature-name>`.

### Commit Message Guidelines
Use clear, concise Conventional Commits formatting so history is easily scannable:

- `feat(modules/home): add core visual modules for hyprland`
- `fix(nvim): resolve lsp autocomplete crash in lua`
- `style: run nix fmt across repository`
- `chore(deps): update fixed-output zephyrDepsHash for lily58`

### Error Recovery & Rollbacks
- If a system switch (`nh os switch`) or build fails catastrophically and you cannot immediately identify the cause, use `git stash` or `git reset --hard HEAD~1` to revert to your last known working micro-commit. Do not attempt to write complex fixes on top of broken, uncommitted code.
