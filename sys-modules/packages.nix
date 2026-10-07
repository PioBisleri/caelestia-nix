{ config, pkgs, ... }: {

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  environment.systemPackages = with pkgs; [
    purge                  # Catppuccin RAM + storage cleanup TUI
    wget                   # Non-interactive network downloader
    yazi                   # Blazing-fast terminal file manager
    obsidian               # Knowledge base / note-taking app
    python3                # Python 3 interpreter
    voxtype-vulkan         # Push-to-talk voice-to-text daemon (Vulkan)
    wtype                  # Wayland keyboard input simulator
    libnotify              # Desktop notifications (notify-send)
    nodejs                 # JavaScript runtime
    jdk17                  # Java Development Kit 17 
    jdk21                  # Java Development Kit 21 (LTS)
    wine-staging           # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    docker                 # Container runtime & orchestration
    dconf-editor           # Low-level GNOME settings editor
    gimp                   # GNU Image Manipulation Program
    sherpa-onnx            # Offline TTS engine (sherpa-onnx-offline-tts)
  ];

}
