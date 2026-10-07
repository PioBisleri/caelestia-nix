{ config, pkgs, pkgs-unstable, vars, ... }: {

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    age                    # Simple modern file encryption
    appimage-run           # Run AppImage files on NixOS
    audacity               # Sound editor with graphical UI
    bat                    # cat clone with syntax highlighting + Git
    bibata-cursors         # Modern cursor theme
    bind.dnsutils          # dig, nslookup, host
    brave                  # Privacy-focused Chromium-based browser
    brightnessctl          # Screen backlight brightness control
    btop                   # Resource monitor with GPU/disk stats
    chafa                  # Terminal image renderer (wallpaper previews)
    cava                   # Audio visualizer (terminal)
    cliphist               # Wayland clipboard history manager
    comma                  # Run uninstalled packages via nix shell
    curl                   # Data transfer with URL syntax
    discord                # All-in-one cross-platform voice and text chat for gamers
    fastfetch              # Fast system info display
    fd                     # Fast user-friendly find alternative
    ffmpeg                 # Audio/video recording, conversion, streaming
    file-roller            # Archive manager GUI
    fuzzel                 # Fast Wayland launcher/dmenu (used by scripts & caelestia CLI)
    fzf                    # Fuzzy finder (history/file search)
    gcc                    # GNU C/C++ compiler
    git                    # Distributed version control
    gnumake                # Build automation tool
    grim                   # Wayland screenshot capture
    hypridle               # Hyprland idle management daemon
    hyprpicker             # Color picker for Hyprland
    hyprshot               # Screenshot tool for Hyprland
    imagemagick            # Image conversion/manipulation
    imv                    # Wayland-native image viewer
    inkscape               # Vector graphics editor
    jmtpfs                 # FUSE filesystem for MTP devices (Java)
    jq                     # JSON processor
    kdePackages.kdenlive   # Qt video editor with VAAPI GPU acceleration
    kitty                  # GPU-accelerated terminal emulator
    lazygit                # Terminal UI for Git
    libmtp                 # MTP device communication library
    matugen                # Material You dynamic color generator (wallpaper theming)
    mpv                    # Minimalist video player (HW-accelerated)
    neovim                 # Modern Vim fork with Lua plugin architecture
    nil                    # Nix language server (LSP)
    nix-index              # nix-index + command-not-found
    nix-output-monitor     # Pretty Nix build output with timing/progress
    nix-tree               # Interactive Nix dependency tree
    nixpkgs-fmt            # Nix code formatter
    nmap                   # Network scanner
    obs-studio             # Screen recording and live streaming
    pamixer                # PulseAudio/PipeWire volume control (CLI)
    pkgs-unstable.opencode # AI coding assistant for terminal (v18.18 from unstable)
    pkgs-unstable.vscodium # Open source source code editor developed by Microsoft for Windows, Linux and macOS (VS Code without MS branding/telemetry/licensing)
    playerctl              # Media player CLI controller (MPRIS)
    polkit_gnome           # Polkit authentication agent (GNOME)
    proton-vpn             # ProtonVPN CLI client
    qbittorrent            # BitTorrent client
    qt6Packages.qt6ct      # Qt6 configuration tool (theming/fonts)
    ripgrep                # Ultra-fast recursive regex search
    scrcpy                 # Display and control Android devices over USB or TCP/IP
    slurp                  # Wayland region/highlight selector
    sops                   # Secret management (encrypted YAML/JSON)
    sox                    # Audio processing
    ssh-to-age             # Convert SSH keys to AGE keys
    starship               # Minimal, fast, customizable shell prompt
    swappy                 # Screenshot annotation / quick-edit tool
    swaybg                 # Wallpaper viewer (instant wallpaper during shell startup)
    tmux                   # Terminal multiplexer
    tree                   # Display directory structure as a tree
    typora                 # A minimal Markdown editor and reader
    unrar                  # Extract RAR archives
    unzip                  # Extract ZIP archives
    vim                    # Linux text editor
    wf-recorder            # Wayland screen recorder (wlroots)
    wireshark              # Network protocol analyzer
    wl-clipboard           # Wayland clipboard utilities (wl-copy/paste)
    yq                     # YAML/JSON/XML processor (use `yq-go` in nixpkgs)
    yt-dlp                 # YouTube/video downloader
    zathura                # Minimal PDF viewer
    zoxide                 # Smarter cd — learns your directory habits
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  xdg.desktopEntries = {
    "gemini-web" = {
      name = "Gemini";
      exec = "brave --app=https://gemini.google.com --user-data-dir=/home/${vars.username}/.config/webapps/gemini";
      icon = "google-gemini";
      categories = [ "Network" ];
    };
    "instagram-web" = {
      name = "Instagram";
      exec = "brave --app=https://instagram.com --user-data-dir=/home/${vars.username}/.config/webapps/instagram";
      icon = "instagram";
      categories = [ "Network" ];
    };
    "notebooklm-web" = {
      name = "NotebookLM";
      exec = "brave --app=https://notebooklm.google.com --user-data-dir=/home/${vars.username}/.config/webapps/notebooklm";
      categories = [ "Network" ];
    };
    "ytmusic-web" = {
      name = "YouTube Music";
      exec = "brave --app=https://music.youtube.com --user-data-dir=/home/${vars.username}/.config/webapps/ytmusic";
      icon = "youtube-music";
      categories = [ "Network" ];
    };
    "whatsapp-web" = {
      name = "WhatsApp";
      exec = "brave --app=https://web.whatsapp.com --user-data-dir=/home/${vars.username}/.config/webapps/whatsapp";
      icon = "whatsapp";
      categories = [ "Network" ];
    };
  };

  xdg.configFile."yazi/yazi.toml" = {
    text = ''
      [open]
      rules = [
        { mime = "*", use = "edit" }
      ]

      [open-editors]
      edit = [
        { run = 'nvim "$@"', block = true }
      ]
    '';
  };

  xdg.configFile."swappy/config" = {
    text = ''
      [Default]
      save_dir=/home/${vars.username}/Pictures/Screenshots
      save_filename_format=shot_%Y%m%d_%H%M%S
    '';
  };


  xdg.configFile."Thunar/volman.xml" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <channel name="thunar-volman" version="1.0">
        <property name="automount-media" type="bool" value="true"/>
        <property name="automount-drives" type="bool" value="true"/>
        <property name="autoopen-media" type="bool" value="true"/>
        <property name="autophoto" type="bool" value="true"/>
      </channel>
    '';
  };
}
