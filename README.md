# nixos-caelestia

[![NixOS](https://img.shields.io/badge/NixOS-26.05-blue?logo=nixos)](https://nixos.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-Lua-blueviolet)](https://hyprland.org/)
[![Caelestia](https://img.shields.io/badge/Shell-Caelestia-blue)](https://github.com/caelestia-dots/shell)
[![Home Manager](https://img.shields.io/badge/Home%20Manager-declarative-green)](https://github.com/nix-community/home-manager)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-green.svg)](LICENSE)

My NixOS configuration — Hyprland + Caelestia shell, fully declarative, with dynamic
matugen theming and sops-nix secrets.

## Features

- NixOS 26.05 + Hyprland (Lua config) + Caelestia quickshell
- Dynamic Material-You theming via matugen (hyprland, kitty, fuzzel, btop, starship, gtk, qt6ct)
- Caelestia panel/dashboard, clipboard, emoji, session menu, wallpaper + scheme switchers
- GRUB bootloader with catppuccin theme, btrfs roots, systemd-boot? — see `sys-modules/base.nix`
- sops-nix secrets encrypted with age
- GTK/Thunar CSS overrides in `gtk-css/`

## Layout

| Path | Description |
| --- | --- |
| `flake.nix`, `flake.lock` | Flake definition + pinned inputs |
| `configuration.nix`, `hardware-configuration.nix` | System entry / hardware probe |
| `home.nix`, `vars.nix` | Home Manager state version & user vars |
| `hm-modules/` | Home Manager modules (caelestia, hyprland, kitty, matugen, scripts, …) |
| `sys-modules/` | NixOS modules (base, audio, display, gaming, hardware, sddm, secrets, …) |
| `gtk-css/` | GTK3/GTK4 custom CSS |
| `secrets/` | sops-nix age-encrypted secrets |
| `install.sh` | Bootstrap: copies config into `/etc/nixos` and runs the rebuild |
| `configure.sh` | Interactive setup — writes your local `vars.nix` |
| `vars.example.nix` | Template for the gitignored, local `vars.nix` |
| `README.md` | This file |

## Apply

```bash
cd nixos-caelestia
./configure.sh          # or: cp vars.example.nix vars.nix and edit it
sudo ./install.sh       # copies to /etc/nixos, dry-run build, backs up /boot, switch
```

or manually:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

## Secrets

`secrets/*.yaml` are age-encrypted. Edit with an age key matching `.sops.yaml`:

```bash
sops secrets/system.yaml
```

## Keybinds

SUPER is the main modifier. Press `SUPER + K` for the full keybind menu (with
descriptions), `SUPER + W` for the wallpaper picker, `SUPER + Space` for the
launcher.

## Rice notes

- waybar → Caelestia bar, swaync → Caelestia notifications, wofi → Caelestia launcher
- `hyprland.conf` replaced by Lua (`hyprland.lua` + `hypr/conf/*.lua`)
- Matugen generates: hyprland colors, kitty theme, fuzzel colors, btop theme,
  zathura, starship, qt6ct. Re-theme with `SUPER W` (wallpaper) or
  `SUPER SHIFT T` (scheme/flavour/dark-light). State cached in
  `~/.cache/matugen-state`; first-boot bootstrap fills missing outputs.
- Hyprland plugins: hypr-dynamic-cursors,
  borders-plus-plus.

## License

GPL-3.0 — see [LICENSE](LICENSE).
