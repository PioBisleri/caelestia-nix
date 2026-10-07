# nixos-caelestia

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
| `README-COPY.md` | Notes on what changed during the rice session |

## Apply

```bash
cd nixos-caelestia
sudo ./install.sh        # copies to /etc/nixos, dry-run build, backs up /boot, switch
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

## License

GPL-3.0 — see [LICENSE](LICENSE).
