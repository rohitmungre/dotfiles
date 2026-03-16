# ── Emacs-style keybindings (default) ─────────
bindkey -e

# ── History search ────────────────────────────
bindkey '^[[A' history-search-backward    # Up arrow
bindkey '^[[B' history-search-forward     # Down arrow
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# ── Word movement ─────────────────────────────
bindkey '^[[1;5C' forward-word            # Ctrl+Right
bindkey '^[[1;5D' backward-word           # Ctrl+Left
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# ── Editing ───────────────────────────────────
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^Y' yank

# ── Accept autosuggestion ─────────────────────
bindkey '^F' autosuggest-accept           # Ctrl+F to accept
bindkey '^[f' forward-word                # Alt+F for partial accept

# ── History ───────────────────────────────────
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS   # Don't store duplicates
setopt HIST_FIND_NO_DUPS      # Don't show duplicates in search
setopt HIST_REDUCE_BLANKS     # Remove blank lines
setopt SHARE_HISTORY          # Share between sessions
setopt INC_APPEND_HISTORY     # Write immediately
setopt EXTENDED_HISTORY       # Add timestamps
setopt HIST_VERIFY            # Show before executing history expansion
