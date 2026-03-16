# dotfiles

> My development environment. One command to feel at home on any machine.

```
Terminal   Ghostty
Shell      Zsh + Zinit
Prompt     Starship
Editor     Neovim (LazyVim)
Mux        tmux + TPM
Tools      mise, ripgrep, fd, bat, eza, fzf, delta, lazygit, k9s
AI         Claude Code
Managed    GNU Stow
```

---

## Quick Start

```bash
# Clone
git clone https://github.com/rohitmungre/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install everything
make install
```

That's it. The install script handles package installation, symlink management via GNU Stow, and plugin setup.

---

## What's Inside

```
dotfiles/
├── zsh/                  # Shell config, aliases, functions, plugins
│   └── .zshrc
│   └── .zsh/
│       ├── aliases.zsh
│       ├── functions.zsh
│       ├── exports.zsh
│       ├── keybindings.zsh
│       └── completions.zsh
├── nvim/                 # Neovim config (LazyVim-based)
│   └── .config/nvim/
│       ├── init.lua
│       └── lua/
│           ├── config/
│           │   ├── autocmds.lua
│           │   ├── keymaps.lua
│           │   ├── lazy.lua
│           │   └── options.lua
│           └── plugins/
│               ├── coding.lua
│               ├── editor.lua
│               ├── lsp.lua
│               ├── ui.lua
│               └── treesitter.lua
├── ghostty/              # Ghostty terminal config
│   └── .config/ghostty/
│       └── config
├── tmux/                 # tmux config + TPM plugins
│   └── .tmux.conf
├── starship/             # Starship prompt theme
│   └── .config/starship.toml
├── git/                  # Git config, aliases, delta diff
│   ├── .gitconfig
│   └── .gitignore_global
├── lazygit/              # lazygit TUI config
│   └── .config/lazygit/
│       └── config.yml
├── k9s/                  # k9s Kubernetes TUI config
│   └── .config/k9s/
│       └── config.yaml
├── mise/                 # Runtime version manager (replaces asdf/nvm/pyenv)
│   └── .config/mise/
│       └── config.toml
├── claude/               # Claude Code global config
│   └── .claude/
│       └── CLAUDE.md
├── bat/                  # bat (better cat) config
│   └── .config/bat/
│       └── config
├── scripts/              # Utility scripts
│   └── bin/
│       ├── cleanup-docker
│       ├── kctx
│       └── git-trim
├── Brewfile              # macOS package manifest
├── Makefile              # Install/update orchestrator
├── install.sh            # Bootstrap script
└── README.md
```

---

## Stack Rationale

| Choice | Why |
|---|---|
| **Ghostty** | GPU-accelerated, native macOS/Linux, Zig-based. Fastest terminal I've tested. |
| **Zsh + Zinit** | Zinit's turbo mode loads plugins asynchronously — shell starts in <50ms. |
| **Starship** | Rust-based prompt. Shows git status, k8s context, Python/Node versions. Fast. |
| **Neovim + LazyVim** | LazyVim gives you a full IDE out of the box. Lazy.nvim for plugin management. |
| **tmux + TPM** | Session persistence. Pair with Ghostty's native splits for the best of both. |
| **mise** | Single tool replaces nvm, pyenv, rbenv, tfenv. Written in Rust. |
| **GNU Stow** | Dead simple symlink management. Each directory maps to `$HOME`. |
| **delta** | Syntax-highlighted diffs in git. Better than any GUI diff tool. |
| **Claude Code** | AI pair programming in the terminal. Global CLAUDE.md for project standards. |

---

## Key Bindings

### tmux (prefix: `Ctrl-a`)

| Key | Action |
|---|---|
| `prefix + \|` | Vertical split |
| `prefix + -` | Horizontal split |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize panes |
| `prefix + z` | Zoom pane |
| `prefix + s` | Session picker |

### Neovim (leader: `Space`)

| Key | Action |
|---|---|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep |
| `<leader>e` | File explorer (neo-tree) |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>gg` | Lazygit |

---

## Installation Details

### Prerequisites

- macOS or Linux (Debian/Ubuntu/Arch)
- `git` and `curl`

### What `make install` does

1. **Detects OS** and installs the appropriate package manager (Homebrew on macOS, native on Linux)
2. **Installs packages** from `Brewfile` (macOS) or via apt/pacman (Linux)
3. **Stows dotfiles** — creates symlinks from this repo into `$HOME`
4. **Sets up Neovim** — installs lazy.nvim and syncs all plugins headlessly
5. **Installs tmux plugins** via TPM
6. **Configures mise** — installs default runtimes (Node, Python, Go)

### Updating

```bash
cd ~/.dotfiles
git pull
make update
```

---

## Customization

Local overrides that won't be committed:

- `~/.zshrc.local` — machine-specific shell config
- `~/.gitconfig.local` — work email, signing key
- `~/.config/ghostty/config.local` — per-machine terminal tweaks

---

## License

MIT
