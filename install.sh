#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
DIM='\033[2m'
NC='\033[0m'

info()  { echo -e "${BLUE}→${NC} $1"; }
ok()    { echo -e "${GREEN}✓${NC} $1"; }
warn()  { echo -e "${RED}!${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Detect OS ---

detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)
            if [ -f /etc/debian_version ]; then echo "debian"
            elif [ -f /etc/arch-release ]; then echo "arch"
            elif [ -f /etc/fedora-release ]; then echo "fedora"
            else echo "linux"
            fi ;;
        *) echo "unknown" ;;
    esac
}

OS=$(detect_os)
info "Detected OS: $OS"

# --- Package Installation ---

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add to path for this session
        if [ -d "/opt/homebrew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
    ok "Homebrew ready"
}

install_packages_macos() {
    install_homebrew
    info "Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock
    ok "Packages installed"
}

install_packages_debian() {
    info "Installing packages via apt..."
    sudo apt update -qq
    sudo apt install -y -qq \
        zsh neovim tmux stow git curl wget unzip \
        ripgrep fd-find bat fzf jq yq \
        python3 python3-pip nodejs npm \
        kubectl
    # Install tools not in apt
    install_binary_tools
    ok "Packages installed"
}

install_packages_arch() {
    info "Installing packages via pacman..."
    sudo pacman -Syu --noconfirm \
        zsh neovim tmux stow git curl wget unzip \
        ripgrep fd bat fzf jq yq \
        python nodejs npm \
        kubectl
    install_binary_tools
    ok "Packages installed"
}

install_binary_tools() {
    # Starship
    if ! command -v starship &>/dev/null; then
        info "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi

    # mise
    if ! command -v mise &>/dev/null; then
        info "Installing mise..."
        curl https://mise.run | sh
    fi

    # lazygit
    if ! command -v lazygit &>/dev/null; then
        info "Installing lazygit..."
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        sudo tar xf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit
    fi

    # delta
    if ! command -v delta &>/dev/null; then
        info "Installing delta..."
        cargo install git-delta 2>/dev/null || info "Install delta manually: https://github.com/dandavison/delta"
    fi

    # eza
    if ! command -v eza &>/dev/null; then
        cargo install eza 2>/dev/null || info "Install eza manually: https://github.com/eza-community/eza"
    fi

    # k9s
    if ! command -v k9s &>/dev/null; then
        info "Install k9s manually: https://k9scli.io/topics/install/"
    fi
}

# --- Main ---

case "${1:-install}" in
    packages)
        case "$OS" in
            macos)  install_packages_macos ;;
            debian) install_packages_debian ;;
            arch)   install_packages_arch ;;
            fedora) warn "Fedora: install packages manually, then run 'make stow'" ;;
            *)      warn "Unknown OS. Install packages manually, then run 'make stow'" ;;
        esac
        ;;
    install)
        case "$OS" in
            macos)  install_packages_macos ;;
            debian) install_packages_debian ;;
            arch)   install_packages_arch ;;
            *)      warn "Unknown OS — skipping package install" ;;
        esac

        info "Stowing dotfiles..."
        cd "$DOTFILES_DIR"
        make stow

        info "Setting up Neovim..."
        make nvim

        info "Setting up tmux..."
        make tmux

        info "Setting up mise runtimes..."
        make mise

        # Set zsh as default shell
        if [ "$SHELL" != "$(which zsh)" ]; then
            info "Setting zsh as default shell..."
            chsh -s "$(which zsh)" || warn "Run manually: chsh -s $(which zsh)"
        fi

        echo ""
        ok "All done. Restart your terminal or run: exec zsh"
        ;;
    *)
        warn "Usage: ./install.sh [install|packages]"
        exit 1
        ;;
esac
