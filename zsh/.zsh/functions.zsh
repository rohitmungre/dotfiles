# ── Directory Creation & Navigation ───────────
mkcd() { mkdir -p "$1" && cd "$1"; }

# ── Git ───────────────────────────────────────

# Interactive branch switching with fzf
fbr() {
    local branches branch
    branches=$(git --no-pager branch -vv --sort=-committerdate) &&
    branch=$(echo "$branches" | fzf +m --ansi --preview 'git log --oneline --graph --color=always {1} -- | head -20') &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Interactive git log with fzf
flog() {
    git log --oneline --graph --color=always --decorate |
    fzf --ansi --no-sort --reverse --tiebreak=index \
        --preview 'git show --color=always {2}' \
        --bind 'enter:execute(git show --color=always {2} | less -R)'
}

# Quick commit with message
gac() { git add -A && git commit -m "$*"; }

# Create and push a new branch
gnew() {
    git switch -c "$1" && git push -u origin "$1"
}

# Clean up merged branches
git-trim() {
    git branch --merged main | grep -v "main\|master\|\*" | xargs -n 1 git branch -d
    git remote prune origin
}

# ── Kubernetes ────────────────────────────────

# Quick port-forward
kpf() {
    local pod=${1:?Pod name required}
    local ports=${2:?Port mapping required (e.g., 8080:80)}
    kubectl port-forward "$pod" "$ports"
}

# Get all resources in a namespace
kall() {
    local ns=${1:-default}
    kubectl get all -n "$ns"
}

# Exec into a pod
ksh() {
    local pod=${1:?Pod name required}
    kubectl exec -it "$pod" -- /bin/sh
}

# Follow logs for a deployment
klf() {
    local deploy=${1:?Deployment name required}
    stern "$deploy" --tail 50
}

# ── Docker ────────────────────────────────────

# Shell into a running container
dsh() {
    docker exec -it "$1" /bin/sh
}

# Stop all running containers
dstop() {
    docker stop $(docker ps -q) 2>/dev/null
    echo "All containers stopped."
}

# ── File & Search ─────────────────────────────

# Interactive file search with preview
f() {
    local file
    file=$(fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --color=always --style=numbers --line-range=:200 {}')
    [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

# Search file contents and open in editor
s() {
    local result
    result=$(rg --line-number --no-heading --color=always "${1:-.}" |
        fzf --ansi --delimiter=: \
            --preview 'bat --color=always --highlight-line {2} {1}' \
            --preview-window '~3:+{2}+3/2')
    [ -n "$result" ] && ${EDITOR:-nvim} "$(echo "$result" | cut -d: -f1)" "+$(echo "$result" | cut -d: -f2)"
}

# ── Network ───────────────────────────────────

# Check if a host/port is reachable
check() {
    local host=${1:?Host required}
    local port=${2:-443}
    nc -zv "$host" "$port" 2>&1
}

# ── Utilities ─────────────────────────────────

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.tar.xz)    tar xJf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a file"
    fi
}

# Quick notes
note() {
    local notes_dir="$HOME/notes"
    mkdir -p "$notes_dir"
    if [ -z "$1" ]; then
        ${EDITOR:-nvim} "$notes_dir"
    else
        echo "$(date '+%Y-%m-%d %H:%M') — $*" >> "$notes_dir/quick.md"
        echo "Noted."
    fi
}

# JSON pretty print from clipboard
jsonp() {
    if [ -t 0 ]; then
        pbpaste | python3 -m json.tool | bat -l json
    else
        python3 -m json.tool | bat -l json
    fi
}

# Simple timer
timer() {
    local seconds=${1:?Seconds required}
    echo "Timer: ${seconds}s"
    sleep "$seconds" && echo "⏰ Done!" && (afplay /System/Library/Sounds/Glass.aiff 2>/dev/null || echo -e '\a')
}
