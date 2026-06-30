# dotfiles

My personal zsh/tmux/git setup. Minimal on purpose — no prompt framework, no plugin manager.

## Install

```sh
git clone git@github.com:gboruk/dotfiles.git ~/Dev/dotfiles
cd ~/Dev/dotfiles
./install.sh
```

`install.sh` is **replace-with-backup, not merge**. For each managed file below, it backs up
whatever real file currently exists at the target path (to `~/.dotfiles_backup/<timestamp>/`),
then symlinks this repo's version into place. It does not snapshot or merge an existing setup —
if you (on a future machine) or anyone else runs this, you/they get *this* config, not a blend of
what was already there. Your prior files are preserved only as a backup, not folded in. It's safe
to re-run: already-correct symlinks are skipped.

It also creates `~/.gitconfig.local` (untracked, never symlinked) pre-filled with
`gboruk@gmail.com` if one doesn't already exist — **the first thing to edit if this repo is ever
installed by someone else**, since otherwise they'd inherit my email/git identity. Fill in
`user.name` there too.

`~/.config/gh/hosts.yml` (the `gh` CLI's OAuth token) is never read, copied, or touched by this
repo or `install.sh`.

## What's managed

| Repo file | Symlinked to | What it does |
|---|---|---|
| `zsh/zshrc` | `~/.zshrc` | PATH, `$DEV_DIR`, history settings, tmux auto-start, sources `zsh/aliases.zsh` |
| `git/gitconfig` | `~/.gitconfig` | git defaults + aliases; includes `~/.gitconfig.local` for identity |
| `git/ignore` | `~/.config/git/ignore` | global gitignore (`.DS_Store`, Claude settings) |
| `tmux/tmux.conf` | `~/.tmux.conf` | prefix `C-a`, vi copy-mode, mouse, status bar |
| `gh/config.yml` | `~/.config/gh/config.yml` | GitHub CLI config (`co` = `pr checkout`) |

`zsh/aliases.zsh` is sourced directly from `~/Dev/dotfiles` by `zshrc` — it isn't symlinked
separately.

## Aliases & functions

| Name | Does |
|---|---|
| `gs` | `git status` |
| `cdd` | cd to `$DEV_DIR` |
| `cdd <name>` | cd into a matching subproject under `$DEV_DIR` |
| `ll` | `ls -lah` |
| `mkcd <dir>` | `mkdir -p` then `cd` into it |
| `reload` | re-source `~/.zshrc` |
| `git co` / `git br` / `git st` | checkout / branch / status -sb |
| `git last` | show the last commit |
| `git unstage` | unstage everything |
| `git contains <ref>` | branches containing a commit |
| `git release-notes` | commit subjects only, `git log --pretty=%s` |
| `git lg` | graph log, one line per commit |

`$DEV_DIR` defaults to `~/Dev` — change it in `zsh/zshrc` if your projects live elsewhere.

## History

This repo used to be a 2014-2017 Rails/iOS dotfiles setup built around a single since-deleted
project (`$BASE_DIR` pointed at a Rails app called "StoriesWeb"). It had no install automation, a
compiled `subl` binary checked into git by accident, and no zsh support at all. Everything
project-specific was dropped in the rewrite: the Rails MVC nav aliases (`cdm`/`cdc`/`cdv`/`cdt`/`cdi`),
`serv`/`tserv`, `unlockmdb`, `deploy`, the `rcov_*` test aliases, `doc`, `depo`, RVM, MacPorts, and
the hand-installed MySQL/MongoDB/Android SDK paths. `gs` and the spirit of `cdd` survived, rebuilt
to not depend on a project that no longer exists.
