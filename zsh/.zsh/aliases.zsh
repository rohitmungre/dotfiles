# ── Navigation ─────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# ── Modern Replacements ───────────────────────
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first --git"
alias lt="eza --tree --level=3 --icons --group-directories-first"
alias la="eza -la --icons"
alias cat="bat --paging=never"
alias grep="rg"
alias find="fd"
alias top="btop 2>/dev/null || htop"
alias diff="delta"
alias du="dust 2>/dev/null || du -h"
alias df="duf 2>/dev/null || df -h"
alias ping="prettyping --nolegend 2>/dev/null || ping"

# ── Editor ────────────────────────────────────
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias e="$EDITOR"

# ── Git ───────────────────────────────────────
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend --no-edit"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gl="git log --oneline --graph --decorate -20"
alias gla="git log --oneline --graph --decorate --all"
alias gd="git diff"
alias gds="git diff --staged"
alias gco="git checkout"
alias gsw="git switch"
alias gsc="git switch -c"
alias gb="git branch"
alias gbd="git branch -d"
alias gst="git stash"
alias gstp="git stash pop"
alias gf="git fetch --all --prune"
alias grb="git rebase"
alias grbi="git rebase -i"
alias lg="lazygit"

# ── Docker ────────────────────────────────────
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dprune="docker system prune -af --volumes"

# ── Kubernetes ────────────────────────────────
alias k="kubectl"
alias kx="kubectx"
alias kn="kubens"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kgd="kubectl get deploy"
alias kgi="kubectl get ingress"
alias kga="kubectl get all"
alias kgn="kubectl get nodes"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kd="kubectl describe"
alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"
alias ktp="kubectl top pods"
alias ktn="kubectl top nodes"
alias kk="k9s"

# ── Python ────────────────────────────────────
alias py="python3"
alias pip="python3 -m pip"
alias venv="python3 -m venv .venv && source .venv/bin/activate"
alias act="source .venv/bin/activate 2>/dev/null || source venv/bin/activate"

# ── Node ──────────────────────────────────────
alias nr="npm run"
alias ni="npm install"
alias nid="npm install -D"

# ── Terraform ─────────────────────────────────
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfd="terraform destroy"

# ── Utilities ─────────────────────────────────
alias reload="exec zsh"
alias path='echo -e ${PATH//:/\\n}'
alias myip="curl -s https://ifconfig.me"
alias localip="ipconfig getifaddr en0 2>/dev/null || hostname -I | awk '{print \$1}'"
alias weather="curl -s wttr.in/?format=3"
alias ports="lsof -i -P -n | grep LISTEN"
alias week="date +%V"
alias timestamp="date +%s"
alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'
alias sizeof="du -sh"
alias serve="python3 -m http.server 8000"

# ── Safety ────────────────────────────────────
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias mkdir="mkdir -pv"

# ── Dotfiles ──────────────────────────────────
alias dots="cd ~/.dotfiles"
alias dotse="cd ~/.dotfiles && $EDITOR"
