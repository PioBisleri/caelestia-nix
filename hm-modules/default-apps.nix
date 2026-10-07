{ config, pkgs, ... }: {

  xdg.mimeApps.enable = true;

  xdg.mimeApps.defaultApplications = {
    # --- Browser ---
    "x-scheme-handler/http" = "brave-browser.desktop";
    "x-scheme-handler/https" = "brave-browser.desktop";
    "x-scheme-handler/about" = "brave-browser.desktop";
    "x-scheme-handler/unknown" = "brave-browser.desktop";
    "x-scheme-handler/ftp" = "brave-browser.desktop";
    "x-scheme-handler/mailto" = "brave-browser.desktop";
    "text/html" = "brave-browser.desktop";

    # --- File manager ---
    "inode/directory" = "thunar.desktop";

    # --- Terminal ---
    "x-scheme-handler/terminal" = "kitty.desktop";

    # --- Text / Code ---
    "text/plain" = "nvim.desktop";
    "text/markdown" = "typora.desktop";
    "text/csv" = "nvim.desktop";
    "text/tab-separated-values" = "nvim.desktop";
    "text/x-nix" = "nvim.desktop";
    "text/x-shellscript" = "nvim.desktop";
    "text/x-python" = "nvim.desktop";
    "text/x-java" = "nvim.desktop";
    "text/x-c" = "nvim.desktop";
    "text/x-c++" = "nvim.desktop";
    "text/x-rust" = "nvim.desktop";
    "text/x-javascript" = "nvim.desktop";
    "text/x-typescript" = "nvim.desktop";
    "text/x-json" = "nvim.desktop";
    "text/x-toml" = "nvim.desktop";
    "text/x-yaml" = "nvim.desktop";
    "text/x-dockerfile" = "nvim.desktop";
    "text/x-makefile" = "nvim.desktop";
    "text/css" = "nvim.desktop";
    "text/xml" = "nvim.desktop";
    "text/x-tex" = "nvim.desktop";
    "text/x-asm" = "nvim.desktop";
    "text/x-lua" = "nvim.desktop";
    "text/x-ruby" = "nvim.desktop";
    "text/x-perl" = "nvim.desktop";
    "text/x-haskell" = "nvim.desktop";
    "text/x-diff" = "nvim.desktop";
    "text/x-log" = "nvim.desktop";

    # --- Documents ---
    "application/pdf" = "zathura.desktop";
    "application/postscript" = "zathura.desktop";
    "application/rtf" = "zathura.desktop";
    "application/epub+zip" = "zathura.desktop";

    # --- Images ---
    "image/png" = "imv.desktop";
    "image/jpeg" = "imv.desktop";
    "image/webp" = "imv.desktop";
    "image/gif" = "imv.desktop";
    "image/svg+xml" = "inkscape.desktop";
    "image/bmp" = "imv.desktop";
    "image/tiff" = "imv.desktop";
    "image/x-tga" = "imv.desktop";
    "image/x-ico" = "imv.desktop";
    "image/x-portable-pixmap" = "imv.desktop";
    "image/x-portable-graymap" = "imv.desktop";
    "image/x-portable-bitmap" = "imv.desktop";
    "image/x-xcf" = "gimp.desktop";
    "image/vnd.adobe.photoshop" = "gimp.desktop";
    "image/x-psd" = "gimp.desktop";

    # --- Video ---
    "video/mp4" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "video/avi" = "mpv.desktop";
    "video/mpeg" = "mpv.desktop";
    "video/quicktime" = "mpv.desktop";
    "video/x-msvideo" = "mpv.desktop";
    "video/x-flv" = "mpv.desktop";
    "video/x-ms-wmv" = "mpv.desktop";
    "video/ogg" = "mpv.desktop";
    "video/3gpp" = "mpv.desktop";
    "video/x-ogm+ogg" = "mpv.desktop";
    "video/mp2t" = "mpv.desktop";
    "video/x-m4v" = "mpv.desktop";
    "video/x-flic" = "mpv.desktop";

    # --- Audio ---
    "audio/mpeg" = "mpv.desktop";
    "audio/mp4" = "mpv.desktop";
    "audio/wav" = "mpv.desktop";
    "audio/x-wav" = "mpv.desktop";
    "audio/flac" = "mpv.desktop";
    "audio/x-flac" = "mpv.desktop";
    "audio/ogg" = "mpv.desktop";
    "audio/x-matroska" = "mpv.desktop";
    "audio/aac" = "mpv.desktop";
    "audio/x-aac" = "mpv.desktop";
    "audio/webm" = "mpv.desktop";
    "audio/x-ms-wma" = "mpv.desktop";
    "audio/x-aiff" = "mpv.desktop";
    "audio/x-mpegurl" = "mpv.desktop";
    "audio/x-scpls" = "mpv.desktop";
    "audio/opus" = "mpv.desktop";
    "audio/3gpp" = "mpv.desktop";
    "audio/midi" = "mpv.desktop";
    "audio/x-mod" = "mpv.desktop";

    # --- Archives ---
    "application/zip" = "file-roller.desktop";
    "application/x-zip-compressed" = "file-roller.desktop";
    "application/x-tar" = "file-roller.desktop";
    "application/gzip" = "file-roller.desktop";
    "application/x-gzip" = "file-roller.desktop";
    "application/x-bzip" = "file-roller.desktop";
    "application/x-bzip2" = "file-roller.desktop";
    "application/x-xz" = "file-roller.desktop";
    "application/x-zstd" = "file-roller.desktop";
    "application/x-7z-compressed" = "file-roller.desktop";
    "application/x-rar-compressed" = "file-roller.desktop";
    "application/vnd.rar" = "file-roller.desktop";
    "application/x-cpio" = "file-roller.desktop";
    "application/x-archive" = "file-roller.desktop";
    "application/x-compress" = "file-roller.desktop";
    "application/x-compressed-tar" = "file-roller.desktop";
    "application/x-brotli" = "file-roller.desktop";
    "application/x-lzip" = "file-roller.desktop";
    "application/x-lzma" = "file-roller.desktop";
    "application/x-lzop" = "file-roller.desktop";
    "application/x-deb" = "file-roller.desktop";
    "application/x-rpm" = "file-roller.desktop";
    "application/x-tarz" = "file-roller.desktop";
    "application/x-iso9660-image" = "file-roller.desktop";

    # --- Torrents ---
    "application/x-bittorrent" = "qbittorrent.desktop";

    # --- AppImage ---
    "application/x-appimage" = "appimage-run.desktop";
  };
}
