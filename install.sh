#!/usr/bin/env bash
# seri-cli installer — curl -fsSL <url> | bash

set -euo pipefail

VERSION="5.0.0"
REPO="https://raw.githubusercontent.com/lain-iwakura-exe/seri-cli/main"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
SCRIPT_NAME="seri-cli"

RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[1;33m'
CYN='\033[0;36m'
BOLD='\033[1m'
RST='\033[0m'

info()  { printf "${CYN}[*]${RST} %s\n" "$*"; }
ok()    { printf "${GRN}[v]${RST} %s\n" "$*"; }
warn()  { printf "${YLW}[!]${RST} %s\n" "$*"; }
die()   { printf "${RED}[x]${RST} %s\n" "$*"; exit 1; }

banner() {
    printf "${CYN}${BOLD}"
    cat << 'EOF'
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
EOF
    printf "${RST}  installer v${VERSION}\n\n"
}

detect_distro() {
    if command -v pacman &>/dev/null; then
        echo "arch"
    elif command -v apt &>/dev/null; then
        echo "debian"
    elif command -v dnf &>/dev/null; then
        echo "fedora"
    elif command -v zypper &>/dev/null; then
        echo "opensuse"
    else
        echo "unknown"
    fi
}

install_deps() {
    local distro="$1"
    local missing=()

    for cmd in curl mpv fzf jq python3 aria2c; do
        command -v "$cmd" &>/dev/null || missing+=("$cmd")
    done

    if [[ ${#missing[@]} -eq 0 ]]; then
        ok "All required system dependencies already installed."
        return 0
    fi

    warn "Missing: ${missing[*]}"
    case "$distro" in
        arch)
            info "Installing missing deps via pacman..."
            sudo pacman -S --noconfirm --needed curl mpv fzf jq python aria2 || die "pacman install failed"
            ;;
        debian)
            info "Installing missing deps via apt..."
            sudo apt-get update
            sudo apt-get install -y curl mpv fzf jq python3 aria2 || die "apt install failed"
            ;;
        fedora)
            info "Installing missing deps via dnf..."
            sudo dnf install -y curl mpv fzf jq python3 aria2 || die "dnf install failed"
            ;;
        opensuse)
            info "Installing missing deps via zypper..."
            sudo zypper install -y curl mpv fzf jq python3 aria2 || die "zypper install failed"
            ;;
        *)
            die "Auto-install not supported on this distro. Please install: curl mpv fzf jq python3 aria2"
            ;;
    esac
}

install_sericli() {
    local install_path="${INSTALL_DIR}/${SCRIPT_NAME}"

    info "Downloading seri-cli ${VERSION}..."

    if ! curl -fsSL "${REPO}/seri-cli" -o "/tmp/seri-cli.$$" 2>/dev/null; then
        die "Download failed. Check your connection."
    fi

    chmod +x "/tmp/seri-cli.$$"

    if [[ -w "$INSTALL_DIR" ]]; then
        mv "/tmp/seri-cli.$$" "$install_path"
    else
        info "Requires sudo to write to ${INSTALL_DIR}..."
        sudo mv "/tmp/seri-cli.$$" "$install_path"
    fi

    ok "Installed to ${install_path}"
}

install_shell_completion() {
    local bash_comp="/usr/share/bash-completion/completions/seri-cli"
    sudo mkdir -p "$(dirname "$bash_comp")" 2>/dev/null || true
    cat << 'COMP' | sudo tee "$bash_comp" > /dev/null 2>&1 || true
_seri_cli() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local opts="-H --history -u --update -h --help -v --version"
    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
}
complete -F _seri_cli seri-cli
COMP

    local fish_comp="$HOME/.config/fish/completions/seri-cli.fish"
    mkdir -p "$(dirname "$fish_comp")" 2>/dev/null || true
    cat << 'FISH' > "$fish_comp" 2>/dev/null || true
complete -c seri-cli -s H -l history  -d "Show history"
complete -c seri-cli -s u -l update   -d "Update seri-cli"
complete -c seri-cli -s h -l help     -d "Show help"
complete -c seri-cli -s v -l version  -d "Show version"
FISH

    ok "Shell completions installed (bash + fish)"
}

verify() {
    if command -v seri-cli &>/dev/null; then
        ok "seri-cli is ready: $(command -v seri-cli)"
    else
        warn "seri-cli installed but not in PATH."
        warn "Add ${INSTALL_DIR} to your PATH, then restart your shell."
    fi
}

main() {
    banner

    local distro
    distro=$(detect_distro)
    info "Detected distro family: ${distro}"

    install_deps "$distro"
    install_sericli
    install_shell_completion
    verify

    printf "\n${CYN}${BOLD}All done!${RST}\n"
    printf "  Run ${BOLD}seri-cli --help${RST} to get started.\n"
    printf "  Run ${BOLD}seri-cli \"Breaking Bad\"${RST} to start streaming.\n\n"
}

main "$@"
