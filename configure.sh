#!/usr/bin/env bash
# Interactive setup: writes vars.nix for this machine.
# vars.nix is gitignored — it is local-only and never committed.
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="$REPO/vars.nix"

ask() { # ask <prompt> <default>
  local prompt="$1" default="$2" reply
  read -rp "$prompt [$default]: " reply </dev/tty || reply="$default"
  printf '%s' "${reply:-$default}"
}

echo "== Create $OUT =="
username=$(ask "System username" "veer")
hostname=$(ask "Hostname" "nixos")
timezone=$(ask "Timezone (e.g. Asia/Kolkata)" "Asia/Kolkata")
fullName=$(ask "Full name" "")
email=$(ask "Email" "")

cat > "$OUT" <<EOF
{
  username = "$username";
  hostname = "$hostname";
  timezone = "$timezone";
  fullName = "$fullName";
  email = "$email";
}
EOF
chmod 644 "$OUT"
echo "Wrote $OUT"
cat "$OUT"
