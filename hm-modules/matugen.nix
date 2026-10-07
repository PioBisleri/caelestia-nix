{ lib, pkgs, vars, ... }: {

  xdg.configFile."matugen/config.toml".text = ''
    [config]
    version_check = false
    caching = false

    [config.wallpaper]
    set = false
    command = "caelestia wallpaper -f '{{ image }}'"

    [templates.hyprland]
    input_path = "/home/${vars.username}/.config/matugen/templates/hyprland-colors.lua"
    output_path = "/home/${vars.username}/.config/matugen/hyprland-colors.lua"
    post_hook = 'hyprctl reload >/dev/null 2>&1 || true'

    [templates.kitty]
    input_path = "/home/${vars.username}/.config/matugen/templates/kitty-colors.conf"
    output_path = "/home/${vars.username}/.config/matugen/kitty-colors.conf"
    post_hook = 'pkill -SIGUSR1 kitty >/dev/null 2>&1 || true'

    [templates.fuzzel]
    input_path = "/home/${vars.username}/.config/matugen/templates/fuzzel.ini"
    output_path = "/home/${vars.username}/.config/matugen/fuzzel-colors.ini"

    [templates.btop]
    input_path = "/home/${vars.username}/.config/matugen/templates/btop.theme"
    output_path = "/home/${vars.username}/.config/btop/themes/matugen.theme"
    post_hook = 'pkill -USR2 btop >/dev/null 2>&1 || true'

    [templates.zathura]
    input_path = "/home/${vars.username}/.config/matugen/templates/zathura-colors"
    output_path = "/home/${vars.username}/.config/zathura/zathurarc"

    [templates.starship]
    input_path = "/home/${vars.username}/.config/matugen/templates/starship.toml"
    output_path = "/home/${vars.username}/.config/starship.toml"

    [templates.hyprlock]
    input_path = "/home/${vars.username}/.config/matugen/templates/hyprlock.conf"
    output_path = "/home/${vars.username}/.config/hypr/hyprlock.conf"

    [templates.qt6ct]
    input_path = "/home/${vars.username}/.config/matugen/templates/qt6ct-colors.conf"
    output_path = "/home/${vars.username}/.config/matugen/qt6ct-colors.conf"
  '';

  xdg.configFile."matugen/templates/hyprland-colors.lua".text = ''
    return {
        image = "{{image}}",
    <* for name, value in colors *>
        {{name}} = "0xff{{value.default.hex_stripped}}",
    <* endfor *>
    }
  '';

  xdg.configFile."matugen/templates/kitty-colors.conf".text = ''
    # --- Main Colors ---
    background            {{ colors.surface.default.hex }}
    foreground            {{ colors.on_surface.default.hex }}
    cursor                {{ colors.on_surface.default.hex }}
    cursor_text_color     {{ colors.surface.default.hex }}

    selection_background  {{ colors.secondary_container.default.hex }}
    selection_foreground  {{ colors.on_secondary_container.default.hex }}

    url_color             {{ colors.tertiary.default.hex }}

    # --- ANSI Colors ---
    color0                {{ colors.surface.default.hex }}
    color1                {{ colors.error.default.hex }}
    color2                {{ colors.tertiary.default.hex }}
    color3                {{ colors.secondary.default.hex }}
    color4                {{ colors.primary.default.hex }}
    color5                {{ colors.tertiary_fixed_dim.default.hex }}
    color6                {{ colors.secondary_fixed_dim.default.hex }}
    color7                {{ colors.on_surface.default.hex }}

    color8                {{ colors.surface_variant.default.hex }}
    color9                {{ colors.error_container.default.hex }}
    color10               {{ colors.tertiary_container.default.hex }}
    color11               {{ colors.secondary_container.default.hex }}
    color12               {{ colors.primary_container.default.hex }}
    color13               {{ colors.on_secondary_fixed_variant.default.hex }}
    color14               {{ colors.on_tertiary_fixed_variant.default.hex }}
    color15               {{ colors.on_surface_variant.default.hex }}

    # --- Starship Prompt Bubbles ---
    color255              {{ colors.primary_container.default.hex }}
    color254              {{ colors.primary.default.hex }}
    color253              {{ colors.secondary_container.default.hex }}
    color252              {{ colors.secondary.default.hex }}
    color251              {{ colors.tertiary_container.default.hex }}
    color250              {{ colors.tertiary.default.hex }}
    color249              {{ colors.error_container.default.hex }}
    color248              {{ colors.error.default.hex }}

    color232              {{ colors.on_primary_container.default.hex }}
    color233              {{ colors.on_primary.default.hex }}
    color234              {{ colors.on_secondary_container.default.hex }}
    color235              {{ colors.on_secondary.default.hex }}
    color236              {{ colors.on_tertiary_container.default.hex }}
    color237              {{ colors.on_tertiary.default.hex }}
    color238              {{ colors.on_error_container.default.hex }}
    color239              {{ colors.on_error.default.hex }}
    color240              {{ colors.on_primary_container.default.hex }}

    # Matched with unthemed light/dark
    color243              {{ colors.primary.default.hex }}
    color244              {{ colors.error.default.hex }}
    color245              {{ colors.outline_variant.default.hex }}

    # --- UI Elements ---
    active_tab_foreground   {{ colors.on_primary.default.hex }}
    active_tab_background   {{ colors.primary.default.hex }}
    inactive_tab_foreground {{ colors.on_primary_container.default.hex }}
    inactive_tab_background {{ colors.primary_container.default.hex }}

    active_border_color     {{ colors.primary.default.hex }}
    inactive_border_color   {{ colors.outline.default.hex }}

    # --- Marks ---
    mark1_foreground        {{ colors.on_primary_fixed.default.hex }}
    mark1_background        {{ colors.primary_fixed.default.hex }}
    mark2_foreground        {{ colors.on_secondary_fixed.default.hex }}
    mark2_background        {{ colors.secondary_fixed.default.hex }}
    mark3_foreground        {{ colors.on_tertiary_fixed.default.hex }}
    mark3_background        {{ colors.tertiary_fixed.default.hex }}
  '';

  xdg.configFile."matugen/templates/fuzzel.ini".text = ''
    # Fuzzel Colors
    # Generated with Matugen

    [colors]
    background={{colors.background.default.hex_stripped}}ff
    text={{colors.on_surface.default.hex_stripped}}ff
    prompt={{colors.secondary.default.hex_stripped}}ff
    placeholder={{colors.tertiary.default.hex_stripped}}ff
    input={{colors.primary.default.hex_stripped}}ff
    match={{colors.tertiary.default.hex_stripped}}ff
    selection={{colors.primary.default.hex_stripped}}ff
    selection-text={{colors.on_surface.default.hex_stripped}}ff
    selection-match={{colors.on_primary.default.hex_stripped}}ff
    counter={{colors.secondary.default.hex_stripped}}ff
    border={{colors.primary.default.hex_stripped}}ff'';

  xdg.configFile."matugen/templates/btop.theme".text = ''
    # Matugen template for btop


    # Colors should be in 6 or 2 character hexadecimal or single spaced rgb decimal: "#RRGGBB", "#BW" or "0-255 0-255 0-255"
    # example for white: "#ffffff", "#ff" or "255 255 255".

    # All graphs and meters can be gradients
    # For single color graphs leave "mid" and "end" variable empty.
    # Use "start" and "end" variables for two color gradient
    # Use "start", "mid" and "end" for three color gradient

    # Main background, empty for terminal default, need to be empty if you want transparent background
    theme[main_bg]=""

    # Main text color
    theme[main_fg]="{{colors.on_surface.default.hex}}"

    # Title color for boxes
    theme[title]="{{colors.primary.default.hex}}"

    # Highlight color for keyboard shortcuts
    theme[hi_fg]="{{colors.secondary.default.hex}}"

    # Background color of selected item in processes box
    theme[selected_bg]="{{colors.primary.default.hex}}"

    # Foreground color of selected item in processes box
    theme[selected_fg]="{{colors.on_primary.default.hex}}"

    # Color of inactive/disabled text
    theme[inactive_fg]="{{colors.on_surface_variant.default.hex}}"

    # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
    theme[proc_misc]="{{colors.tertiary.default.hex}}"

    # Cpu box outline color
    theme[cpu_box]="{{colors.outline.default.hex}}"

    # Memory/disks box outline color
    theme[mem_box]="{{colors.outline.default.hex}}"

    # Net up/down box outline color
    theme[net_box]="{{colors.outline.default.hex}}"

    # Processes box outline color
    theme[proc_box]="{{colors.outline.default.hex}}"

    # Box divider line and small boxes line color
    theme[div_line]="{{colors.outline_variant.default.hex}}"

    # Temperature graph colors
    theme[temp_start]="{{colors.secondary.default.hex}}"
    theme[temp_mid]="{{colors.primary.default.hex}}"
    theme[temp_end]="{{colors.error.default.hex}}"

    # CPU graph colors
    theme[cpu_start]="{{colors.secondary.default.hex}}"
    theme[cpu_mid]="{{colors.primary.default.hex}}"
    theme[cpu_end]="{{colors.error.default.hex}}"

    # Mem/Disk free meter
    theme[free_start]="{{colors.secondary.default.hex}}"
    theme[free_mid]=""
    theme[free_end]="{{colors.secondary_container.default.hex}}"

    # Mem/Disk cached meter
    theme[cached_start]="{{colors.tertiary.default.hex}}"
    theme[cached_mid]=""
    theme[cached_end]="{{colors.tertiary_container.default.hex}}"

    # Mem/Disk available meter
    theme[available_start]="{{colors.primary.default.hex}}"
    theme[available_mid]=""
    theme[available_end]="{{colors.primary_container.default.hex}}"

    # Mem/Disk used meter
    theme[used_start]="{{colors.error.default.hex}}"
    theme[used_mid]=""
    theme[used_end]="{{colors.error_container.default.hex}}"

    # Download graph colors
    theme[download_start]="{{colors.secondary.default.hex}}"
    theme[download_mid]="{{colors.primary.default.hex}}"
    theme[download_end]="{{colors.tertiary.default.hex}}"

    # Upload graph colors
    theme[upload_start]="{{colors.secondary.default.hex}}"
    theme[upload_mid]="{{colors.primary.default.hex}}"
    theme[upload_end]="{{colors.tertiary.default.hex}}"'';

  xdg.configFile."matugen/templates/zathura-colors".text = ''
    " -----------------------------------------------------------------------------
    " Zathura settings
    " -----------------------------------------------------------------------------

    " Colors
    set default-bg              "{{colors.on_primary.default.rgba | set_alpha: 1.0}}"
    set default-fg              "{{colors.primary.default.hex}}"

    set statusbar-bg            "{{colors.on_primary.default.hex}}"
    set statusbar-fg            "{{colors.primary.default.hex}}"

    set inputbar-bg             "{{colors.on_primary.default.hex}}"
    set inputbar-fg             "{{colors.primary.default.hex}}"

    set notification-error-bg   "{{colors.on_error.default.hex}}"
    set notification-error-fg   "{{colors.error.default.hex}}"

    set notification-warning-bg "{{colors.primary_fixed.default.hex}}"
    set notification-warning-fg "{{colors.error_container.default.hex}}"

    set highlight-color         "{{colors.primary_fixed.default.hex}}"
    set highlight-active-color  "{{colors.primary_fixed_dim.default.hex}}"

    set completion-highlight-fg "{{colors.on_primary.default.hex}}"
    set completion-highlight-bg "{{colors.primary.default.hex}}"

    set completion-bg           "{{colors.on_primary.default.hex}}"
    set completion-fg           "{{colors.primary.default.hex}}"

    set notification-bg         "{{colors.on_primary.default.hex}}"
    set notification-fg         "{{colors.primary.default.hex}}"

    set recolor                 "true"
    set recolor-lightcolor      "{{colors.on_primary.default.rgba | set_alpha: 1.0}}"
    set recolor-darkcolor       "{{colors.primary.default.hex}}"
    set recolor-reverse-video   "true"
    set recolor-keephue         "true"

    " Clipboard
    set selection-clipboard clipboard

    " Search
    set incremental-search true
    set search-hadjust true

    " Autoadjust
    set adjust-open width

    " Typography
    set font "FiraCode Nerd Font 12"

    " -----------------------------------------------------------------------------
    " Zathura mappings
    " -----------------------------------------------------------------------------
    " remove status bar
    set guioptions none
    " Zoom in/out
    map [normal]     z zoom in
    map [normal]     Z zoom out
    map [fullscreen] z zoom in
    map [fullscreen] Z zoom out

    " Toggle mode
    map [normal]     D toggle_page_mode
    map [fullscreen] D toggle_page_mode

    " Scroll
    map [normal]     u scroll half-up
    map [normal]     d scroll half-down
    map [fullscreen] u scroll half-up
    map [fullscreen] d scroll half-down

    " Fullscreen
    map [normal]     f toggle_fullscreen
    map [fullscreen] f toggle_fullscreen

    " Reload
    map [normal]     <C-r> reload
    map [fullscreen] <C-r> reload

    " Status bar
    map [normal]     b toggle_statusbar
    map [fullscreen] b toggle_statusbar

    " Set width as in mupdf
    map [normal]     H adjust_window best-fit
    map [normal]     W adjust_window width
    map [fullscreen] H adjust_window best-fit
    map [fullscreen] W adjust_window width

    map [normal]     i set recolor
    map [fullscreen] i set recolor
  '';

  xdg.configFile."matugen/templates/starship.toml".text = ''
    format = "$os $username :: $directory $git_branch$git_status $time\n$character"

    palette = "matugen"

    [palettes.matugen]
    rosewater = "{{ colors.tertiary.default.hex }}"
    flamingo = "{{ colors.on_tertiary_container.default.hex }}"
    pink = "{{ colors.secondary_container.default.hex }}"
    mauve = "{{ colors.primary.default.hex }}"
    maroon = "{{ colors.error_container.default.hex }}"
    red = "{{ colors.error.default.hex }}"
    peach = "{{ colors.secondary_container.default.hex }}"
    yellow = "{{ colors.secondary_fixed_dim.default.hex }}"
    green = "{{ colors.tertiary.default.hex }}"
    teal = "{{ colors.tertiary_container.default.hex }}"
    sky = "{{ colors.tertiary_fixed.default.hex }}"
    sapphire = "{{ colors.secondary_fixed.default.hex }}"
    blue = "{{ colors.primary.default.hex }}"
    lavender = "{{ colors.secondary.default.hex }}"
    text = "{{ colors.on_surface.default.hex }}"
    subtext1 = "{{ colors.on_surface_variant.default.hex }}"
    subtext0 = "{{ colors.on_surface_variant.default.hex }}"
    overlay2 = "{{ colors.outline_variant.default.hex }}"
    overlay1 = "{{ colors.outline.default.hex }}"
    overlay0 = "{{ colors.outline.default.hex }}"
    surface2 = "{{ colors.surface_container_highest.default.hex }}"
    surface1 = "{{ colors.surface_container_high.default.hex }}"
    surface0 = "{{ colors.surface_container.default.hex }}"
    base = "{{ colors.surface.default.hex }}"
    mantle = "{{ colors.background.default.hex }}"
    crust = "{{ colors.surface_dim.default.hex }}"

    [os]
    disabled = false
    style = "bold blue"

    [username]
    show_always = true
    style_user = "bold blue"
    style_root = "bold red"
    format = "[$user]($style)"

    [directory]
    style = "bold green"
    format = "[$path]($style)"
    truncation_length = 3
    truncation_symbol = "../"

    [git_branch]
    format = "[$symbol$branch]($style)"
    style = "bold mauve"

    [git_status]
    style = "mauve"
    format = "[$all_status$ahead_behind]($style)"

    [time]
    disabled = false
    format = "[$time]($style)"
    time_format = "%I:%M %p"
    style = "bold blue"

    [cmd_duration]
    format = "[$duration]($style)"
    style = "bold yellow"
    min_time = 5000

    [nix_shell]
    format = "[$symbol$state($name)]($style)"
    style = "bold lavender"
    symbol = ""

    [character]
    success_symbol = "[▶](bold mauve)"
    error_symbol = "[▶](bold red)"
    vicmd_symbol = "[◀](bold green)"
    format = "$symbol"
  '';

  xdg.configFile."matugen/templates/hyprlock.conf".text = ''
    background {
      monitor =
      path = /home/${vars.username}/.cache/current-wallpaper.jpg
      blur_passes = 3
      blur_size = 8
      brightness = 0.7
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 2
      dots_size = 0.2
      dots_spacing = 0.5
      dots_center = true
      outer_color = rgba(0, 0, 0, 0)
      inner_color = {{ colors.surface_container.default.rgba | set_alpha: 0.8 }}
      font_color = {{ colors.on_surface.default.hex }}
      fade_on_empty = true
      placeholder_text = Password...
      hide_input = false
      round = 10
      check_color = {{ colors.tertiary.default.hex }}
      fail_color = {{ colors.error.default.hex }}
      position = 0, -80
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] echo "$(date '+%I:%M %p')"
      font_size = 72
      font_family = JetBrainsMono Nerd Font
      color = {{ colors.on_surface.default.hex }}
      position = 0, 40
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:86400000] echo "$(date '+%A, %B %d')"
      font_size = 20
      font_family = JetBrainsMono Nerd Font
      color = {{ colors.on_surface_variant.default.hex }}
      position = 0, -20
      halign = center
      valign = center
    }
  '';

  xdg.configFile."matugen/templates/qt6ct-colors.conf".text = ''
    [ColorScheme]
    active_colors=#ff{{ colors.on_surface.default.hex_stripped }}, #ff{{ colors.surface_container_high.default.hex_stripped }}, #ff{{ colors.surface_bright.default.hex_stripped }}, #ff{{ colors.surface_container_highest.default.hex_stripped }}, #ff{{ colors.surface_dim.default.hex_stripped }}, #ff{{ colors.outline_variant.default.hex_stripped }}, #ff{{ colors.on_surface.default.hex_stripped }}, #ff{{ colors.error.default.hex_stripped }}, #ff{{ colors.on_surface.default.hex_stripped }}, #ff{{ colors.surface_container_low.default.hex_stripped }}, #ff{{ colors.surface.default.hex_stripped }}, #ff{{ colors.shadow.default.hex_stripped }}, #ff{{ colors.primary.default.hex_stripped }}, #ff{{ colors.on_primary.default.hex_stripped }}, #ff{{ colors.primary.default.hex_stripped }}, #ff{{ colors.tertiary.default.hex_stripped }}, #ff{{ colors.surface_container.default.hex_stripped }}, #ff{{ colors.surface.default.hex_stripped }}, #ff{{ colors.inverse_surface.default.hex_stripped }}, #ff{{ colors.inverse_on_surface.default.hex_stripped }}, #ff{{ colors.on_surface_variant.default.hex_stripped }}, #ff{{ colors.primary.default.hex_stripped }}
    inactive_colors=#ff{{ colors.on_surface.default.hex_stripped }}, #ff{{ colors.surface_container_high.default.hex_stripped }}, #ff{{ colors.surface_bright.default.hex_stripped }}, #ff{{ colors.surface_container_highest.default.hex_stripped }}, #ff{{ colors.surface_dim.default.hex_stripped }}, #ff{{ colors.outline_variant.default.hex_stripped }}, #ff{{ colors.on_surface.default.hex_stripped }}, #ff{{ colors.error.default.hex_stripped }}, #ff{{ colors.on_surface.default.hex_stripped }}, #ff{{ colors.surface_container_low.default.hex_stripped }}, #ff{{ colors.surface.default.hex_stripped }}, #ff{{ colors.shadow.default.hex_stripped }}, #ff{{ colors.primary.default.hex_stripped }}, #ff{{ colors.on_primary.default.hex_stripped }}, #ff{{ colors.primary.default.hex_stripped }}, #ff{{ colors.tertiary.default.hex_stripped }}, #ff{{ colors.surface_container.default.hex_stripped }}, #ff{{ colors.surface.default.hex_stripped }}, #ff{{ colors.inverse_surface.default.hex_stripped }}, #ff{{ colors.inverse_on_surface.default.hex_stripped }}, #ff{{ colors.on_surface_variant.default.hex_stripped }}, #ff{{ colors.primary.default.hex_stripped }}
    disabled_colors=#ff{{ colors.outline.default.hex_stripped }}, #ff{{ colors.surface_container_high.default.hex_stripped }}, #ff{{ colors.surface_bright.default.hex_stripped }}, #ff{{ colors.surface_container_highest.default.hex_stripped }}, #ff{{ colors.surface_dim.default.hex_stripped }}, #ff{{ colors.outline_variant.default.hex_stripped }}, #ff{{ colors.outline.default.hex_stripped }}, #ff{{ colors.outline_variant.default.hex_stripped }}, #ff{{ colors.outline.default.hex_stripped }}, #ff{{ colors.surface_container_low.default.hex_stripped }}, #ff{{ colors.surface.default.hex_stripped }}, #ff{{ colors.shadow.default.hex_stripped }}, #ff{{ colors.secondary_container.default.hex_stripped }}, #ff{{ colors.outline.default.hex_stripped }}, #ff{{ colors.secondary_container.default.hex_stripped }}, #ff{{ colors.outline_variant.default.hex_stripped }}, #ff{{ colors.surface_container.default.hex_stripped }}, #ff{{ colors.surface.default.hex_stripped }}, #ff{{ colors.inverse_surface.default.hex_stripped }}, #ff{{ colors.outline.default.hex_stripped }}, #ff{{ colors.outline.default.hex_stripped }}, #ff{{ colors.secondary_container.default.hex_stripped }}
  '';

  home.activation.matugenBootstrap = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ ! -f "$HOME/.config/matugen/hyprland-colors.lua" ] \
        || [ ! -f "$HOME/.config/starship.toml" ] \
        || [ ! -f "$HOME/.config/hypr/hyprlock.conf" ] \
        || [ ! -f "$HOME/.config/matugen/qt6ct-colors.conf" ]; then
      wallpaper="$HOME/.cache/current-wallpaper.jpg"
      if [ ! -f "$wallpaper" ]; then
        wallpaper="$(find "$HOME/Pictures/wallpaper" -type f 2>/dev/null | head -n1)"
      fi
      if [ -n "$wallpaper" ] && [ -f "$wallpaper" ]; then
        MTYPE=scheme-tonal-spot
        MMODE=dark
        if [ -f "$HOME/.cache/matugen-state" ]; then
          read -r MTYPE MMODE < "$HOME/.cache/matugen-state" || true
        fi
        MTYPE="''${MTYPE:-scheme-tonal-spot}"
        MMODE="''${MMODE:-dark}"
        run ${lib.getExe pkgs.matugen} image "$wallpaper" -t "$MTYPE" -m "$MMODE" --source-color-index 0 || true
      fi
    fi
  '';
}
