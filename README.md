# dotfiles

Personal shell configuration for [IchigoMilk](https://github.com/IchigoMilk).

## Structure

```
dotfiles/
├── setup.sh          # install script (creates symlinks)
├── shell/
│   ├── aliases.sh    # shared aliases (git, ls, navigation…)
│   └── exports.sh    # shared PATH and environment variables
├── bash/
│   └── .bashrc       # bash configuration
├── zsh/
│   └── .zshrc        # zsh configuration
└── git/
    └── config        # git aliases (included via setup.sh)
```

## Installation

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

Existing `~/.bashrc` / `~/.zshrc` are automatically backed up as
`~/.bashrc.bak.<timestamp>` before being replaced with symlinks.

Run with `--dry-run` to preview without making any changes:

```bash
bash setup.sh --dry-run
```

## Machine-specific overrides

Create `~/.bashrc.local` or `~/.zshrc.local` for settings that should not be
tracked (e.g. work-specific paths, secrets). These files are sourced at the end
of the respective rc file if they exist.

## Notable git aliases

| alias | command |
|-------|---------|
| `git st` | `git status` |
| `git s` | `git status -s` |
| `git l` | `git log --oneline --graph --decorate` |
| `git la` | same, all branches |
| `git d` / `git ds` | diff / diff --staged |
| `git sw` / `git swc` | switch / switch -c |
| `git rbi` | rebase -i |
| `git undo` | reset HEAD~1 --mixed |

Shell aliases mirror these: `gs`, `gl`, `gd`, etc. — see `shell/aliases.sh`.
