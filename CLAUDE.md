# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal zsh/tmux/git dotfiles. Deliberately minimal: no prompt framework, no plugin manager. There is no build, test, or lint step — the only "command" is `./install.sh`, and validation is done by inspection plus sourcing/reloading shells.

## Install model — the central architectural fact

`install.sh` is **replace-with-backup, not merge**. For each entry in the `LINKS` array it:
1. Skips if the target is already the correct symlink (safe to re-run).
2. Otherwise backs up any existing real file to `~/.dotfiles_backup/<timestamp>/`.
3. Symlinks the repo's version into place.

It never reads, snapshots, or blends an existing setup — running it installs *this* config wholesale. Consequences when editing:

- **To add a managed file, add it to the `LINKS` array in `install.sh`** (`"repo/path:$HOME/target"`), not just to the repo. Existence in the repo alone does nothing.
- `zsh/aliases.zsh` is the deliberate exception: it is **sourced directly** from `~/Dev/dotfiles/zsh/aliases.zsh` by `zsh/zshrc`, not symlinked. Editing it takes effect on next shell/`reload` with no install step. (This also hardcodes the `~/Dev/dotfiles` path — moving the repo breaks the source line.)
- `zsh/zshrc` also sources `~/.zshrc.local` last — an untracked, outside-the-repo file for personal/machine/project-specific overrides (mirrors the `~/.gitconfig.local` pattern). It's not scaffolded by `install.sh`; absence is fine. Keep such overrides there, not in the tracked `aliases.zsh`/`zshrc`.

## Identity separation — do not hardcode git identity

`git/gitconfig` (→ `~/.gitconfig`) contains only shared defaults and aliases. It `[include]`s `~/.gitconfig.local`, which is **untracked and never symlinked**. `install.sh` generates `~/.gitconfig.local` pre-filled with `gboruk@gmail.com` only if it doesn't already exist.

Keep all machine/person-specific identity (`user.email`, `user.name`) out of the tracked `git/gitconfig`. It belongs in the generated local file.

## Layout

Each top-level dir maps one tool to its target (see the `LINKS` array and README table for the exact mapping):

- `zsh/` → `~/.zshrc` (+ sourced `aliases.zsh`)
- `git/` → `~/.gitconfig` and `~/.config/git/ignore`
- `tmux/` → `~/.tmux.conf`
- `gh/` → `~/.config/gh/config.yml`

Note two `.gitignore`s with different jobs: repo-root `.gitignore` (what this repo won't track) vs. `git/ignore` (the global gitignore installed to `~/.config/git/ignore`).

## Conventions worth matching

- tmux prefix is `C-a` (not `C-b`); config uses vi copy-mode with `pbcopy` (macOS-specific).
- zsh uses `set -o vi` and auto-`exec`s into a fresh tmux session in interactive shells.
- `$DEV_DIR` (default `~/Dev`) drives the `cdd` helper; it's defined in `zsh/zshrc`.
- `install.sh` runs under `set -euo pipefail` — keep it POSIX-safe bash and idempotent.
