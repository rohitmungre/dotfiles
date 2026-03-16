.PHONY: install update stow unstow brew nvim tmux mise help

STOW_DIRS = zsh nvim ghostty tmux starship git lazygit k9s mise claude bat scripts

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: brew stow nvim tmux mise ## Full install — packages, symlinks, plugins, runtimes
	@echo "\n✓ Done. Restart your shell or run: exec zsh"

update: brew stow nvim-update tmux-update mise-update ## Update everything
	@echo "\n✓ Updated."

# --- Package Management ---

brew: ## Install packages via Homebrew (macOS) or native pkg manager (Linux)
	@./install.sh packages

# --- Symlink Management ---

stow: ## Create symlinks for all configs
	@for dir in $(STOW_DIRS); do \
		echo "  stow $$dir"; \
		stow -v -R -t $(HOME) $$dir 2>/dev/null || true; \
	done

unstow: ## Remove all symlinks
	@for dir in $(STOW_DIRS); do \
		echo "  unstow $$dir"; \
		stow -v -D -t $(HOME) $$dir 2>/dev/null || true; \
	done

# --- Neovim ---

nvim: ## Install Neovim plugins (headless)
	@echo "  nvim: syncing plugins..."
	@nvim --headless '+Lazy! sync' +qa 2>/dev/null || true

nvim-update: ## Update Neovim plugins
	@echo "  nvim: updating plugins..."
	@nvim --headless '+Lazy! update' +qa 2>/dev/null || true

# --- tmux ---

tmux: ## Install tmux plugins via TPM
	@echo "  tmux: installing plugins..."
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi
	@$(HOME)/.tmux/plugins/tpm/bin/install_plugins 2>/dev/null || true

tmux-update: ## Update tmux plugins
	@$(HOME)/.tmux/plugins/tpm/bin/update_plugins all 2>/dev/null || true

# --- mise ---

mise: ## Install default runtimes
	@echo "  mise: installing runtimes..."
	@mise install 2>/dev/null || true

mise-update: ## Update all runtimes
	@mise upgrade 2>/dev/null || true

# --- Cleanup ---

clean: unstow ## Remove symlinks and caches
	@rm -rf $(HOME)/.local/share/nvim
	@rm -rf $(HOME)/.tmux/plugins
	@echo "  Cleaned."
