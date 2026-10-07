{ config, pkgs, vars, ... }: {

  xdg.configFile."hypr/hyprland.lua".text = ''
    pcall(require, "plugins")

    require("conf.input")
    require("conf.animations")
    require("conf.look")
    require("conf.rules")
    require("conf.binds")
    require("conf.autostart")
  '';

  xdg.configFile."hypr/conf/input.lua".text = ''
    hl.monitor({
        output = "",
        mode = "preferred",
        position = "auto",
        scale = 1,
    })

    hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
    hl.env("XCURSOR_SIZE", "24")
    hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
    hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
    hl.env("EDITOR", "nvim")
    hl.env("VISUAL", "nvim")
    hl.env("YAZI_EDITOR", "nvim")
    hl.env("GDK_BACKEND", "wayland,x11")
    hl.env("NIXOS_OZONE_WL", "1")

    hl.config({
        input = {
            kb_layout = "us",
            follow_mouse = 1,
            touchpad = {
                natural_scroll = true,
                tap_to_click = true,
            },
        },
    })
  '';

  xdg.configFile."hypr/conf/animations.lua".text = ''
    hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

    hl.config({
        animations = {
            enabled = true,
        },
    })

    hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
    hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
    hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
    hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
    hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
    hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
  '';

  xdg.configFile."hypr/conf/look.lua".text = ''
    local ok, matugen = pcall(dofile, "/home/veer/.config/matugen/hyprland-colors.lua")
    if not ok or type(matugen) ~= "table" then
        matugen = {}
    end

    local activeBorder = matugen.primary or "0xffcba6f7"
    local inactiveBorder = matugen.outline or "0xff45475a"

    hl.config({
        general = {
            gaps_in = 5,
            gaps_out = 10,
            border_size = 2,
            col = {
                active_border = activeBorder,
                inactive_border = inactiveBorder,
            },
        },

        dwindle = {
            preserve_split = true,
        },

        decoration = {
            rounding = 10,
            active_opacity = 0.96,
            inactive_opacity = 0.90,
            fullscreen_opacity = 1.0,
            blur = {
                enabled = true,
                size = 4,
                passes = 2,
                new_optimizations = true,
                ignore_opacity = true,
            },
            shadow = {
                enabled = true,
                range = 12,
                render_power = 3,
                color = 0x66000000,
            },
        },
    })
  '';

  xdg.configFile."hypr/conf/rules.lua".text = ''
    hl.window_rule({
        match = { class = "^rice-splash$" },
        float = true,
        center = true,
        size = { 560, 200 },
    })

    hl.window_rule({
        match = { class = "^floating-term$" },
        float = true,
        center = true,
        size = { 840, 520 },
    })

    hl.window_rule({
        match = { class = "^btop-term$" },
        float = true,
        center = true,
    })

    hl.window_rule({
        match = { class = "^\\.blueman-manager-wrapped$" },
        float = true,
        center = true,
        size = { 800, 600 },
    })

    hl.window_rule({
        match = { class = "^nm-connection-editor$" },
        float = true,
        center = true,
        size = { 700, 550 },
    })

    hl.window_rule({
        match = { class = "^imv$" },
        float = true,
        move = "10 40",
        size = { 320, 240 },
    })
  '';

  xdg.configFile."hypr/conf/binds.lua".text = ''
    local mod = "SUPER"

    hl.bind(mod .. " + Return", hl.dsp.exec_cmd("kitty"), { description = "Terminal (kitty)" })
    hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd("caelestia clipboard"), { description = "Clipboard history" })
    hl.bind(mod .. " + B", hl.dsp.exec_cmd("brave"), { description = "Browser (brave)" })
    hl.bind(mod .. " + Q", hl.dsp.window.close(), { description = "Close window" })
    hl.bind(mod .. " + Space", hl.dsp.global("caelestia:launcher"), { description = "App launcher" })
    hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
    hl.bind(mod .. " + F", hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })

    hl.bind(mod .. " + E", hl.dsp.exec_cmd("thunar"), { description = "File manager (thunar)" })
    hl.bind(mod .. " + O", hl.dsp.exec_cmd("obsidian"), { description = "Obsidian" })
    hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("caelestia emoji -p"), { description = "Emoji picker" })
    hl.bind(mod .. " + T", hl.dsp.exec_cmd("kitty --class floating-term -o initial_window_width=80c -o initial_window_height=24c"), { description = "Quick terminal" })
    hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd("brave --new-window"), { description = "New browser window" })
    hl.bind(mod .. " + CTRL + B", hl.dsp.exec_cmd("brave --incognito"), { description = "New incognito window" })
    hl.bind(mod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper-select.sh"), { description = "Wallpaper picker" })
    hl.bind(mod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/theme-switcher.sh"), { description = "Theme switcher" })

    hl.bind(mod .. " + A", hl.dsp.exec_cmd("brave --app=https://gemini.google.com --user-data-dir=$HOME/.config/webapps/gemini"), { description = "Gemini" })
    hl.bind(mod .. " + D", hl.dsp.exec_cmd("discord >/dev/null 2>&1 & disown"), { description = "Discord" })
    hl.bind(mod .. " + I", hl.dsp.exec_cmd("brave --app=https://instagram.com --user-data-dir=$HOME/.config/webapps/instagram"), { description = "Instagram" })
    hl.bind(mod .. " + N", hl.dsp.exec_cmd("brave --app=https://notebooklm.google.com --user-data-dir=$HOME/.config/webapps/notebooklm"), { description = "NotebookLM" })
    hl.bind(mod .. " + SHIFT + Y", hl.dsp.exec_cmd("brave --app=https://music.youtube.com --user-data-dir=$HOME/.config/webapps/ytmusic"), { description = "YouTube Music" })
    hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("brave --app=https://web.whatsapp.com --user-data-dir=$HOME/.config/webapps/whatsapp"), { description = "WhatsApp" })

    hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh region"), { description = "Screenshot region" })
    hl.bind(mod .. " + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh output"), { description = "Screenshot output" })
    hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh window"), { description = "Screenshot window" })

    hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("bash -c 'pidof wf-recorder && pkill wf-recorder || wf-recorder -f ~/Pictures/Screenshots/rec_$(date +%Y%m%d_%H%M%S).mp4'"), { description = "Toggle screen recording" })

    hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })

    hl.bind(mod .. " + Escape", hl.dsp.global("caelestia:session"), { description = "Session menu" })

    hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprctl dispatch dpms off"), { description = "Screens off" })
    hl.bind(mod .. " + ALT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload Hyprland config" })

    hl.bind(mod .. " + K", hl.dsp.exec_cmd("~/.config/hypr/scripts/keybinds.sh"), { description = "Keybinds menu" })
    hl.bind(mod .. " + CTRL + N", hl.dsp.global("caelestia:sidebar"), { description = "Toggle sidebar" })

    hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("kitty -e btop"), { description = "System monitor (btop)" })

    hl.bind(mod .. " + grave", hl.dsp.workspace.toggle_special("scratchpad"), { description = "Toggle scratchpad" })
    hl.bind(mod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:scratchpad" }), { description = "Move window to scratchpad" })

    hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
    hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
    hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
    hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

    hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }), { description = "Move window left" })
    hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }), { description = "Move window right" })
    hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }), { description = "Move window up" })
    hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }), { description = "Move window down" })

    hl.bind(mod .. " + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { description = "Shrink window width" })
    hl.bind(mod .. " + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { description = "Grow window width" })
    hl.bind(mod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { description = "Shrink window height" })
    hl.bind(mod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { description = "Grow window height" })

    hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 2 }), { description = "Maximize window" })
    hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split layout" })
    hl.bind(mod .. " + P", hl.dsp.window.pin(), { description = "Pin window" })
    hl.bind("CTRL + Tab", hl.dsp.window.cycle_next(), { description = "Cycle windows" })

    for i = 1, 9 do
        hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }), { description = "Go to workspace " .. i })
        hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
    end

    hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "+1" }), { description = "Next workspace" })
    hl.bind(mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "-1" }), { description = "Previous workspace" })
    hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "+1" }), { description = "Next workspace" })
    hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "-1" }), { description = "Previous workspace" })
    hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "empty" }), { description = "Move window to empty workspace" })

    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
    hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

    hl.bind("F10", hl.dsp.exec_cmd("~/.config/hypr/scripts/tts-speak.sh"), { description = "Read screen aloud" })
    hl.bind("SHIFT + F10", hl.dsp.exec_cmd("~/.config/hypr/scripts/tts-speak.sh --clipboard"), { description = "Read clipboard aloud" })
    hl.bind("F9", hl.dsp.exec_cmd("voxtype record start"), { description = "Start voice recording" })
    hl.bind("F9", hl.dsp.exec_cmd("voxtype record stop"), { release = true, description = "Stop voice recording" })

    hl.bind(mod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Color picker" })

    hl.bind(mod .. " + G", function()
        if hl.plugin and hl.plugin.overview then
            hl.plugin.overview.toggle()
        end
    end, { description = "Toggle workspace overview" })

    hl.bind(mod .. " + R", hl.dsp.submap("resize"), { description = "Resize mode" })

    hl.define_submap("resize", function()
        hl.bind("left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true, description = "Shrink width" })
        hl.bind("right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true, description = "Grow width" })
        hl.bind("up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true, description = "Shrink height" })
        hl.bind("down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true, description = "Grow height" })
        hl.bind("escape", hl.dsp.submap("reset"), { description = "Exit resize mode" })
        hl.bind("Return", hl.dsp.submap("reset"), { description = "Confirm resize" })
    end)

    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true, description = "Volume up" })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true, description = "Volume down" })
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true, repeating = true, description = "Mute" })

    hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { locked = true, description = "Play/pause" })
    hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), { locked = true, description = "Next track" })
    hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), { locked = true, description = "Previous track" })

    hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), { locked = true, repeating = true, description = "Brightness up" })
    hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), { locked = true, repeating = true, description = "Brightness down" })
  '';

  xdg.configFile."hypr/conf/autostart.lua".text = ''
    hl.on("hyprland.start", function()
        hl.exec_cmd("kitty --class rice-splash --title loading -o remember_window_size=no -o initial_window_width=560 -o initial_window_height=200 -o enable_audio_bell=no -o confirm_os_window_close=0 -o background_color=#131317 -o foreground_color=#e5e1e7 -o active_border_color=#c2c1ff -o window_padding_width=16 -o hide_window_decorations=yes -e $HOME/.config/hypr/scripts/startup-splash.sh")
        hl.exec_cmd("systemctl --user import-environment && systemctl --user restart nixos-fake-graphical-session.target")
        hl.exec_cmd('S="$HOME/.cache/current-wallpaper.jpg"; if ! [ -f "$S" ]; then for f in "$HOME"/Pictures/wallpaper/*; do [ -f "$f" ] && ln -sfn "$f" "$S" && break; done; fi; MISSING=0; for o in "$HOME/.config/matugen/hyprland-colors.lua" "$HOME/.config/starship.toml" "$HOME/.config/hypr/hyprlock.conf" "$HOME/.config/matugen/qt6ct-colors.conf"; do [ -f "$o" ] || MISSING=1; done; if [ -f "$S" ] && [ "$MISSING" = "1" ]; then command -v matugen >/dev/null 2>&1 || exit 0; T=scheme-tonal-spot; M=dark; if [ -f "$HOME/.cache/matugen-state" ]; then read -r T M < "$HOME/.cache/matugen-state"; fi; T="''${T:-scheme-tonal-spot}"; M="''${M:-dark}"; matugen image "$S" -t "$T" -m "$M" --source-color-index 0 >/dev/null 2>&1; fi')
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")
        hl.exec_cmd("/run/current-system/sw/bin/polkit-gnome-authentication-agent-1")
        hl.exec_cmd('sleep 1 && command -v caelestia >/dev/null 2>&1 && [ ! -f "$HOME/.local/state/caelestia/scheme.json" ] && caelestia scheme set -n dynamic >/dev/null 2>&1')
    end)
  '';

  xdg.configFile."hypr/plugins.lua".text = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("bash -c 'sleep 2 && hyprctl plugin load ${pkgs.hyprlandPlugins.hyprspace}/lib/libhyprspace.so'")
      hl.exec_cmd("bash -c 'sleep 2 && hyprctl plugin load ${pkgs.hyprlandPlugins.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so'")
      hl.exec_cmd("bash -c 'sleep 2 && hyprctl plugin load ${pkgs.hyprlandPlugins.borders-plus-plus}/lib/libborders-plus-plus.so'")
    end)
  '';

  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
        force_shm = true
    }
  '';
}
