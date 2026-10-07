{ config, pkgs, ... }: {

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Battery monitor - auto switch to power-saver below 20%";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.config/hypr/scripts/battery-monitor.sh";
      Environment = [
        "DISPLAY=:1"
        "WAYLAND_DISPLAY=wayland-1"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
      ];
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers.battery-monitor = {
    Unit = {
      Description = "Periodic battery check (every 3 min)";
    };
    Timer = {
      OnCalendar = "*:0/3";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.ssh-agent.enable = true;

  systemd.user.services.voxtype = {
    Unit = {
      Description = "Voxtype push-to-talk voice-to-text daemon";
      Documentation = "https://voxtype.io";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.voxtype-vulkan}/bin/voxtype daemon";
      Restart = "always";
      RestartSec = 2;
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "DISPLAY=:1"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.voxtype-watchdog = {
    Unit = {
      Description = "Voxtype watchdog - restart if dead";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'if ! systemctl --user is-active -q voxtype; then systemctl --user start voxtype; fi'";
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers.voxtype-watchdog = {
    Unit = {
      Description = "Periodic voxtype health check (every 2 min)";
    };
    Timer = {
      OnCalendar = "*:0/2";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  xdg.configFile."voxtype/config.toml" = {
    force = true;
    text = ''
      state_file = "auto"

      [hotkey]
      enabled = false

      [audio]
      device = "default"
      sample_rate = 16000
      max_duration_secs = 60

      [whisper]
      model = "base.en"
      language = "en"
      threads = 6
      translate = false

      [output]
      mode = "type"
      fallback_to_clipboard = true
      type_delay_ms = 0

      [output.notification]
      on_recording_start = true
      on_recording_stop = true
      on_transcription = true
    '';
  };
}
