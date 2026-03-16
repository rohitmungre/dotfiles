# ─────────────────────────────────────────────
# Ro's Zsh Config
# Managed via dotfiles — github.com/rohitmungre/dotfiles
# ─────────────────────────────────────────────

# ── Zinit ──────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ── Plugins (turbo mode — loads async after prompt) ──
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl

# Syntax highlighting, autosuggestions, completions
zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull"zinit creinstall -q ." \
        zsh-users/zsh-completions

# Useful extras
zinit wait lucid for \
    OMZP::git \
    OMZP::kubectl \
    OMZP::docker-compose \
    OMZP::command-not-found \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh

# zsh-abbr for Fish-style abbreviations
zinit wait lucid for \
    olets/zsh-abbr

# ── Source modular configs ─────────────────────
for config_file in ~/.zsh/{exports,aliases,functions,keybindings,completions}.zsh; do
    [ -f "$config_file" ] && source "$config_file"
done

# ── Tool integrations ─────────────────────────
# Starship prompt
eval "$(starship init zsh)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh 2>/dev/null)" || true

# mise (runtime version manager)
eval "$(mise activate zsh)"

# direnv
eval "$(direnv hook zsh)"

# ── Local overrides (not committed) ───────────
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
