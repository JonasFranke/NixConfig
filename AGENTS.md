# AGENTS.md - Repository Guidelines for AI Assistants

This repository contains declarative NixOS and Home Manager configurations structured as a Nix Flake for multiple hosts (servers and laptops).

---

## 1. Environment & Tech Stack

- **OS / Distro**: NixOS (Linux x86_64)
- **Flake Inputs**:
  - `nixpkgs-stable` (`nixos-26.05`)
  - `nixpkgs-unstable` (`nixos-unstable`)
  - `home-manager` (release branch tracking stable) and `home-manager-unstable`
  - `agenix` for secret management
  - `hyprland`, `zen-browser`, `nix-colors`, `nixos-grub-themes`, `nixvim`
- **JavaScript / TypeScript Runtime**: Bun (as per user preference)
- **Code Formatter**: `nixfmt-tree` (`nix fmt`)

---

## 2. Repository Structure

```
├── flake.nix                  # Flake entry point & nixosConfigurations definitions
├── flake.lock                 # Locked input revisions
├── secrets/                   # Agenix encrypted secrets & secrets.nix key mapping
├── shared/                    # Modules shared across hosts
│   ├── common/                # Baseline configuration (nix settings, secrets, direnv, tailscale)
│   ├── laptop/                # Common laptop modules (bluetooth, fonts, printing, virtualization, GUI apps)
│   │   └── home/              # Shared Home Manager modules (e.g., ghostty, zsh)
│   └── server/                # Shared server modules (ssh, users, tmux, packages, zsh)
└── hosts/                     # Host-specific configurations
    ├── servers/
    │   └── opencloud/         # Nextcloud/OpenCloud server config, BorgBackup, agenix secrets
    └── laptops/
        ├── main/              # Primary laptop config (Hyprland, theme, apps, user `jonas`)
        └── unibook/           # Secondary/Uni laptop config (user `jonasf`)
```

---

## 3. Host Configurations

1. **`opencloud`** (`hosts/servers/opencloud/`):
   - Server running Nextcloud and BorgBackup.
   - Built against `nixpkgs-unstable`.
   - Primary user: Server admin / services.
2. **`nixos`** (Primary laptop, `hosts/laptops/main/`):
   - Built against `nixpkgs-stable` with `pkgs.unstable` overlay.
   - User: `jonas` with Home Manager, Hyprland, `nix-colors`.
3. **`jf-unibook`** (`hosts/laptops/unibook/`):
   - Built against `nixpkgs-stable` with `pkgs.unstable` overlay.
   - User: `jonasf` with Home Manager, `nix-colors`.

---

## 4. Key Conventions & Best Practices

### Nix & Code Style
- **Formatting**: Always format Nix files using `nix fmt` before committing.
- **Modularity**: Place reusable configurations in `shared/` (`shared/common`, `shared/laptop`, or `shared/server`). Only host-specific hardware configurations, credentials, and overrides belong in `hosts/<type>/<hostname>/`.
- **Package Overlays**: Stable hosts access cutting-edge packages via `pkgs.unstable.<pkg>` via the defined overlay in `flake.nix`.
- **Secrets Management**: Secrets are managed with `agenix`. Encrypted files (`.age`) and age public keys must be tracked via `secrets/secrets.nix` or host-level `secrets.nix`. Never commit plaintext secrets.

### Git & Development Workflow
- Work on descriptive feature/fix branches.
- Use concise, imperative commit messages (e.g., `Add unibook config`, `Move zsh and ghostty to shared`).
- When adding new Nix files to git-tracked directories, ensure they are staged (`git add`) so that the Nix Flake evaluator can see them.

---

## 5. Common Commands

- **Check Flake**:
  ```bash
  nix flake check
  ```
- **Format Code**:
  ```bash
  nix fmt
  ```
- **Build / Test Configuration**:
  ```bash
  # Test building a host configuration
  nixos-rebuild build --flake .#nixos
  nixos-rebuild build --flake .#jf-unibook
  nixos-rebuild build --flake .#opencloud
  ```
- **Update Flake Inputs**:
  ```bash
  nix flake update
  # Or update a single input
  nix flake lock --update-input nixpkgs-unstable
  ```
- **Manage Secrets (Agenix)**:
  ```bash
  agenix -e <secret-file>.age
  ```
