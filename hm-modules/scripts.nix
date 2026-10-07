{ ... }: {

  xdg.configFile."hypr/scripts/battery-monitor.sh" = {
    text = ''
      #!/usr/bin/env bash
      BAT=/sys/class/power_supply/BAT0
      [ -f "$BAT/capacity" ] || exit 0
      capacity=$(cat "$BAT/capacity")
      status=$(cat "$BAT/status")
      profile=$(powerprofilesctl get 2>/dev/null)
      if [ "$status" = "Discharging" ] && [ "$capacity" -lt 20 ]; then
        if [ "$profile" != "power-saver" ]; then
          powerprofilesctl set power-saver
          notify-send -u critical "Battery Low" "Battery at ''${capacity}% - switched to power-saver"
        else
          notify-send -u critical "Battery Low" "Battery at ''${capacity}%"
        fi
      fi
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/keybinds.sh" = {
    text = ''
      #!/usr/bin/env bash
      command -v hyprctl >/dev/null 2>&1 || { notify-send "Keybinds" "hyprctl not found"; exit 1; }
      command -v jq >/dev/null 2>&1 || { notify-send "Keybinds" "jq not found"; exit 1; }

      hyprctl binds -j | jq -r '
        def bit($m; $b): (($m / $b) | floor) % 2 == 1;
        .[]
        | (.modmask // 0) as $m
        | (.key // "") as $key
        | ([
            (if bit($m; 64) then "SUPER" else empty end),
            (if bit($m; 8) then "ALT" else empty end),
            (if bit($m; 4) then "CTRL" else empty end),
            (if bit($m; 1) then "SHIFT" else empty end),
            (if bit($m; 128) then "ALTGR" else empty end)
          ] | join(" + ")) as $mods
        | (if $mods == "" then $key else $mods + " + " + $key end) as $combo
        | (.dispatcher // "") as $disp
        | (.arg // "") as $arg
        | (.description // "") as $desc
        | (.submap // "") as $submap
        | (if $desc != "" then $desc
           elif $arg != "" then $disp + " " + $arg
           else $disp end) as $action
        | select($combo != "" and $action != "")
        | $combo + "  ->  " + (if $submap != "" then "[" + $submap + "] " else "" end) + $action
      ' | fuzzel --dmenu --prompt "Keybinds (Esc to close)" >/dev/null
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/memory-manager.sh" = {
    text = ''
      #!/usr/bin/env bash
      selected=$(printf '%s\n' "Memory Info" "Clear RAM Cache" | fuzzel --dmenu --prompt "Memory Manager")
      case "$selected" in
          "Memory Info")
              kitty --class floating-term -o initial_window_width=80c -o initial_window_height=24c -e bash -c 'free -h; echo; echo "Press Enter to exit"; read'
              ;;
          "Clear RAM Cache")
              kitty --class floating-term -e bash -c 'echo "Clearing RAM cache..."; sync && echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null; echo "RAM cache cleared! Press Enter to exit."; read'
              ;;
      esac
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/power-profiles.sh" = {
    text = ''
      #!/usr/bin/env bash
      PROFILES=$(powerprofilesctl list | grep -oP '^(\s{2}|\* )\K\S+(?=:)')
      SELECTED=$(printf '%s\n' "$PROFILES" | fuzzel --dmenu --prompt "Power Profile")
      [ -z "$SELECTED" ] && exit 0
      powerprofilesctl set "$SELECTED"
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/screenshot.sh" = {
    text = ''
      #!/usr/bin/env bash
      DIR=/home/veer/Pictures/Screenshots
      NAME=shot_$(date +%Y%m%d_%H%M%S).png
      mkdir -p "$DIR"
      FILE=$DIR/$NAME

      case "''${1:-region}" in
        region)  hyprshot -m region -o "$DIR" -f "$NAME" || exit 1 ;;
        output)  hyprshot -m output -o "$DIR" -f "$NAME" || exit 1 ;;
        window)  hyprshot -m window -o "$DIR" -f "$NAME" || exit 1 ;;
      esac

      notify-send -i "$FILE" -t 7000 "Screenshot" "Click preview to edit"
      imv -s 0.15 -x "$FILE" 2>/dev/null &
      IMV_PID=$!
      (sleep 7; kill "$IMV_PID" 2>/dev/null) &
      wait "$IMV_PID" 2>/dev/null
      swappy -f "$FILE"
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/startup-splash.sh" = {
    text = ''
      #!/usr/bin/env bash
      W="$HOME/.cache/current-wallpaper.jpg"
      if [ ! -e "$W" ]; then
        for f in "$HOME"/Pictures/wallpaper/*; do
          [ -f "$f" ] && ln -sfn "$f" "$W" && break
        done
      fi

      ready() {
        hyprctl layers 2>/dev/null | grep -q "namespace: caelestia-background"
      }

      ready && exit 0

      SWPID=""
      if command -v swaybg >/dev/null 2>&1 && [ -e "$W" ]; then
        swaybg -i "$W" -m fill >/dev/null 2>&1 &
        SWPID=$!
      fi

      clear
      printf '\n\n   ✦ caelestia\n\n'
      sp='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
      i=0
      t=0
      ok=0
      while [ "$t" -lt 150 ]; do
        if ready; then
          ok=1
          break
        fi
        printf '\r   %s  starting shell…' "''${sp:$i:1}"
        i=$((i + 1))
        t=$((t + 1))
        sleep 0.1
      done

      if [ "$ok" = "1" ]; then
        printf '\r   \u2713 ready%s    \n' " "
        sleep 0.5
        [ -n "$SWPID" ] && kill "$SWPID" 2>/dev/null
      else
        printf '\r   shell still starting — wallpaper left on%s   \n' " "
      fi
      exit 0
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/theme-switcher.sh" = {
    text = ''
      #!/usr/bin/env bash
      set -u

      STATE_FILE="$HOME/.cache/matugen-state"
      WALLPAPER_LINK="$HOME/.cache/current-wallpaper.jpg"
      WALLPAPER_DIR="$HOME/Pictures/wallpaper"

      read_state() {
        MTYPE="scheme-tonal-spot"
        MMODE="dark"
        if [ -f "$STATE_FILE" ]; then
          read -r MTYPE MMODE < "$STATE_FILE" || true
        fi
        MTYPE="''${MTYPE:-scheme-tonal-spot}"
        MMODE="''${MMODE:-dark}"
      }

      to_matugen_type() {
        case "$1" in
          tonalspot) echo "scheme-tonal-spot" ;;
          fruitsalad) echo "scheme-fruit-salad" ;;
          *) echo "scheme-$1" ;;
        esac
      }

      run_matugen() {
        wp="$WALLPAPER_LINK"
        if [ ! -f "$wp" ]; then
          wp=$(find "$WALLPAPER_DIR" -type f 2>/dev/null | head -n1)
        fi
        if [ -n "$wp" ] && [ -f "$wp" ]; then
          matugen image "$wp" -t "$1" -m "$2" --source-color-index 0 >/dev/null 2>&1 || true
        fi
        printf '%s %s\n' "$1" "$2" > "$STATE_FILE"
      }

      CUR=$(caelestia scheme get 2>/dev/null || true)
      CUR_NAME=$(printf '%s\n' "$CUR" | sed -n 's/^ *Name: //p' | head -n1)
      CUR_MODE=$(printf '%s\n' "$CUR" | sed -n 's/^ *Mode: //p' | head -n1)
      CUR_VARIANT=$(printf '%s\n' "$CUR" | sed -n 's/^ *Variant: //p' | head -n1)
      read_state

      LABELS=()
      ACTS=()

      add() {
        if [ "$1" = "1" ]; then LABELS+=("● $2"); else LABELS+=("  $2"); fi
        ACTS+=("$3")
      }

      iscur() {
        if [ "$1" = "$2" ]; then echo 1; else echo 0; fi
      }

      add "$(iscur "$CUR_NAME" "dynamic")" "Scheme: dynamic (follow wallpaper)" "dynamic"
      for fam in catppuccin darkgreen dracula everblush everforest gruvbox nord oldworld onedark rosepine shadotheme solarized tokyonight caelestia; do
        add "$(iscur "$CUR_NAME" "$fam")" "Scheme: $fam" "scheme|$fam"
      done

      add "$(iscur "$CUR_MODE" "dark")" "Mode: dark" "mode|dark"
      add "$(iscur "$CUR_MODE" "light")" "Mode: light" "mode|light"

      for v in tonalspot vibrant expressive fidelity fruitsalad monochrome neutral rainbow content; do
        add "$(iscur "$CUR_VARIANT" "$v")" "Variant: $v" "variant|$v"
      done

      add 0 "Random scheme" "rand-scheme"
      add 0 "Random wallpaper" "rand-wallpaper"

      pick_flavour() {
        printf '%s\n' $1 | fuzzel --dmenu --prompt "Flavour: $2"
      }

      apply_scheme() {
        name="$1"
        flavour=""
        multi=0
        case "$name" in
          catppuccin) multi=1; flavour=$(pick_flavour "frappe latte macchiato mocha" "$name") ;;
          darkgreen) multi=1; flavour=$(pick_flavour "hard medium" "$name") ;;
          everforest) multi=1; flavour=$(pick_flavour "hard medium soft" "$name") ;;
          gruvbox) multi=1; flavour=$(pick_flavour "hard medium soft" "$name") ;;
          rosepine) multi=1; flavour=$(pick_flavour "dawn main moon" "$name") ;;
        esac
        if [ "$multi" = "1" ] && [ -z "$flavour" ]; then
          return 0
        fi
        if [ -n "$flavour" ]; then
          caelestia scheme set -n "$name" -f "$flavour" --notify
        else
          caelestia scheme set -n "$name" --notify
        fi
      }

      random_wallpaper() {
        wp=$(find "$WALLPAPER_DIR" -type f 2>/dev/null | shuf -n1)
        [ -z "$wp" ] && return 0
        ln -sfn "$wp" "$WALLPAPER_LINK"
        caelestia wallpaper -f "$wp"
        run_matugen "$MTYPE" "$MMODE"
      }

      SEL=$(printf '%s\n' "''${LABELS[@]}" | fuzzel --dmenu --prompt "Theme switcher (Esc cancels)")
      [ -z "$SEL" ] && exit 0

      ACT=""
      for i in "''${!LABELS[@]}"; do
        if [ "''${LABELS[$i]}" = "$SEL" ]; then ACT="''${ACTS[$i]}"; fi
      done
      [ -z "$ACT" ] && exit 0

      case "$ACT" in
        dynamic)
          caelestia scheme set -n dynamic --notify
          run_matugen "$MTYPE" "$MMODE"
          ;;
        scheme\|*)
          apply_scheme "''${ACT#scheme|}"
          ;;
        mode\|*)
          mode="''${ACT#mode|}"
          caelestia scheme set -m "$mode" --notify
          run_matugen "$MTYPE" "$mode"
          ;;
        variant\|*)
          v="''${ACT#variant|}"
          caelestia scheme set -v "$v" --notify
          run_matugen "$(to_matugen_type "$v")" "$MMODE"
          ;;
        rand-scheme)
          caelestia scheme set -r --notify
          ;;
        rand-wallpaper)
          random_wallpaper
          ;;
      esac
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/tts-speak.sh" = {
    text = ''
      #!/usr/bin/env bash
      set -u
      CACHE_DIR=''${XDG_CACHE_HOME:-$HOME}/.cache/tts/kokoro
      MODEL_DIR="$CACHE_DIR"
      MODEL_URL="https://github.com/k2-fsa/sherpa-onnx/releases/download/tts-models/kokoro-en-v0_19.tar.bz2"
      MODEL_FILE="$MODEL_DIR/model.onnx"
      TOKENS_FILE="$MODEL_DIR/tokens.txt"
      DATA_DIR="$MODEL_DIR/espeak-ng-data"
      VOICES_FILE="$MODEL_DIR/voices.bin"
      SID=0
      SHERPA="/run/current-system/sw/bin/sherpa-onnx-offline-tts"

      if [ ! -f "$MODEL_FILE" ]; then
        mkdir -p "$MODEL_DIR"
        ARCHIVE="/tmp/kokoro.tar.bz2"
        notify-send -t 5000 "TTS" "Downloading Kokoro model..."
        curl -L -o "$ARCHIVE" "$MODEL_URL" 2>&1
        if [ $? -ne 0 ]; then
          notify-send -u critical "TTS" "Download failed!"
          exit 1
        fi
        tar -xjf "$ARCHIVE" -C "$MODEL_DIR" --strip-components=1 2>/dev/null || tar -xjf "$ARCHIVE" -C "$MODEL_DIR" 2>/dev/null
        rm -f "$ARCHIVE"
        if [ ! -f "$MODEL_FILE" ]; then
          notify-send -u critical "TTS" "Model extraction failed!"
          exit 1
        fi
        notify-send -t 3000 "TTS" "Model ready!"
      fi

      MODE=''${1:-selection}
      if [ "$MODE" = "--clipboard" ]; then
        TEXT=$(wl-paste 2>/dev/null)
        [ -z "$TEXT" ] && TEXT=$(wl-paste --primary 2>/dev/null)
      else
        notify-send -t 2000 "TTS" "Select text..."
        sleep 0.5
        TEXT=$(wl-paste --primary 2>/dev/null)
        [ -z "$TEXT" ] && TEXT=$(wl-paste 2>/dev/null)
        if [ -z "$TEXT" ] && command -v wtype &>/dev/null; then
          wtype -M ctrl c -m ctrl 2>/dev/null
          sleep 0.3
          TEXT=$(wl-paste 2>/dev/null)
        fi
      fi

      TEXT=$(echo "$TEXT" | head -c 500)
      [ -z "$TEXT" ] && notify-send -t 3000 "TTS" "No text found" && exit 0

      notify-send -t 2000 "TTS" "Generating speech..."
      OUTPUT_WAV=/tmp/tts_output.wav
      "$SHERPA" --kokoro-model="$MODEL_FILE" --kokoro-tokens="$TOKENS_FILE" --kokoro-data-dir="$DATA_DIR" --kokoro-voices="$VOICES_FILE" --sid="$SID" --num-threads=6 --output-filename="$OUTPUT_WAV" "$TEXT" 2>/dev/null

      if [ -f "$OUTPUT_WAV" ]; then
        pw-play "$OUTPUT_WAV" 2>/dev/null || aplay "$OUTPUT_WAV" 2>/dev/null || notify-send -u critical "TTS" "Playback failed"
        rm -f "$OUTPUT_WAV"
      else
        notify-send -u critical "TTS" "Speech generation failed"
      fi
    '';
    executable = true;
  };

  xdg.configFile."hypr/scripts/wallpaper-select.sh" = {
    text = ''
      #!/usr/bin/env bash
      WALLPAPER_DIR="$HOME/Pictures/wallpaper"
      SYMLINK="$HOME/.cache/current-wallpaper.jpg"

      mkdir -p "$(dirname "$SYMLINK")"

      ENTRIES=""
      for f in "$WALLPAPER_DIR"/* "$WALLPAPER_DIR"/*/*; do
        [ -f "$f" ] || continue
        ext="''${f##*.}"; ext="''${ext,,}"
        case "$ext" in
          jpg|jpeg|png|webp|tif|tiff|svg|gif|bmp|avif|jxl) ENTRIES+="$f"$'\n' ;;
        esac
      done
      [ -z "$ENTRIES" ] && exit 0

      if [ -z "$KITTY_WINDOW_ID" ]; then
        exec kitty --class floating-term -o initial_window_width=140c -o initial_window_height=28c -o confirm_os_window_close=0 -e "$0" "$@"
      fi

      SELECTED=$(printf '%s' "$ENTRIES" | sort | fzf --ansi --prompt='Wallpaper> ' --header='Enter to set, Esc to cancel' \
        --preview 'chafa --size="''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES}" {}' \
        --preview-window='~2,75%' --bind='ctrl-n:down,ctrl-p:up' --border=rounded)
      [ -z "$SELECTED" ] && exit 0
      [ -f "$SELECTED" ] || exit 0

      ln -sfn "$SELECTED" "$SYMLINK"
      caelestia wallpaper -f "$SELECTED"
      MTYPE=scheme-tonal-spot
      MMODE=dark
      if [ -f "$HOME/.cache/matugen-state" ]; then
        read -r MTYPE MMODE < "$HOME/.cache/matugen-state" || true
      fi
      MTYPE="''${MTYPE:-scheme-tonal-spot}"
      MMODE="''${MMODE:-dark}"
      matugen image "$SELECTED" -t "$MTYPE" -m "$MMODE" --source-color-index 0
    '';
    executable = true;
  };
}
