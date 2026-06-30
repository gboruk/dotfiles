#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

LINKS=(
  "zsh/zshrc:$HOME/.zshrc"
  "git/gitconfig:$HOME/.gitconfig"
  "git/ignore:$HOME/.config/git/ignore"
  "tmux/tmux.conf:$HOME/.tmux.conf"
  "gh/config.yml:$HOME/.config/gh/config.yml"
)

link() {
  local src="$REPO_DIR/$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    echo "skip   $target (already linked)"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
    echo "backup $target -> $BACKUP_DIR/$(basename "$target")"
  fi

  ln -s "$src" "$target"
  echo "link   $target -> $src"
}

for entry in "${LINKS[@]}"; do
  link "${entry%%:*}" "${entry#*:}"
done

GITCONFIG_LOCAL="$HOME/.gitconfig.local"
if [ ! -e "$GITCONFIG_LOCAL" ]; then
  cat > "$GITCONFIG_LOCAL" <<'EOF'
[user]
    email = gboruk@gmail.com
    # name = Your Name
EOF
  echo "create $GITCONFIG_LOCAL (edit user.name)"
else
  echo "skip   $GITCONFIG_LOCAL (already exists)"
fi

echo "done."
