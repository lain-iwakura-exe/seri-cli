#!/usr/bin/env bash
# seri-cli installer — torrent version (requires peerflix)

set -euo pipefail

VERSION="4.5.0"
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
ok()    { printf "${GRN}[✓]${RST} %s\n" "$*"; }
warn()  { printf "${YLW}[!]${RST} %s\n" "$*"; }
die()   { printf "${RED}[✗]${RST} %s\n" "$*"; exit 1; }

banner() {
    printf "${CYN}${BOLD}"
    cat << 'EOF'
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
EOF
    printf "${RST}  installer v${VERSION} — Torrent streaming\n\n"
}

detect_distro() {
    if command -v pacman &>/dev/null; then
        echo "arch"
    elif command -v apt &>/dev/null; then
        echo "debian"
    elif command -v dnf &>/dev/null; then
        echo "fedora"
    else
        echo "unknown"
    fi
}

install_deps() {
    local distro="$1"
    local missing=()

    for cmd in curl mpv fzf jq python3 nodejs npm; do
        command -v "$cmd" &>/dev/null || missing+=("$cmd")
    done

    if [[ ${#missing[@]} -eq 0 ]]; then
        ok "All required dependencies already installed."
    else
        warn "Missing: ${missing[*]}"

        case "$distro" in
            arch)
                info "Installing missing deps via pacman…"
                sudo pacman -S --noconfirm --needed "${missing[@]}" || die "pacman install failed"
                ;;
            debian)
                info "Installing missing deps via apt…"
                sudo apt-get update -y
                sudo apt-get install -y "${missing[@]}" || die "apt install failed"
                ;;
            fedora)
                info "Installing missing deps via dnf…"
                sudo dnf install -y "${missing[@]}" || die "dnf install failed"
                ;;
            *)
                die "Auto-install not supported. Please install: ${missing[*]}"
                ;;
        esac
    fi

    # Install peerflix globally
    if ! command -v peerflix &>/dev/null; then
        info "Installing peerflix via npm…"
        sudo npm install -g peerflix || die "peerflix install failed"
        ok "peerflix installed"
    else
        ok "peerflix already installed"
    fi
}

install_sericli() {
    local install_path="${INSTALL_DIR}/${SCRIPT_NAME}"

    info "Downloading seri-cli ${VERSION}…"

    if ! curl -fsSL "${REPO}/seri-cli" -o "/tmp/seri-cli.$$" 2>/dev/null; then
        die "Download failed. Check your connection."
    fi

    chmod +x "/tmp/seri-cli.$$"

    if [[ -w "$INSTALL_DIR" ]]; then
        mv "/tmp/seri-cli.$$" "$install_path"
    else
        info "Requires sudo to write to ${INSTALL_DIR}…"
        sudo mv "/tmp/seri-cli.$$" "$install_path"
    fi

    ok "Installed to ${install_path}"
}

install_man_page() {
    local man_dir="/usr/local/share/man/man1"
    local man_file="${man_dir}/seri-cli.1"

    command -v gzip &>/dev/null || return 0
    sudo mkdir -p "$man_dir"

    cat << 'MANPAGE' | gzip | sudo tee "${man_file}.gz" > /dev/null
.TH SERI-CLI 1 "2024" "seri-cli 4.5.0" "User Commands"
.SH NAME
seri-cli \- stream series, movies and films in MPV on Linux
.SH SYNOPSIS
.B seri-cli
[\fIOPTIONS\fR] [\fIQUERY\fR]
.SH DESCRIPTION
seri-cli is a command-line tool for searching and streaming series, movies,
and films from 1980 to 2026 using fzf for selection and MPV for playback.
.SH OPTIONS
.TP
.B \-H, \-\-history
Show watch history.
.TP
.B \-u, \-\-update
Update seri-cli to the latest version.
.TP
.B \-h, \-\-help
Show help message.
.TP
.B \-v, \-\-version
Show version number.
.SH EXAMPLES
.PP
Search for a TV show:
.RS
seri-cli "Breaking Bad"
.RE
.PP
Stream a movie:
.RS
seri-cli "The Dark Knight"
.RE
.SH FILES
.TP
.I ~/.config/seri-cli/config
User configuration file.
.TP
.I ~/.local/share/seri-cli/history
Watch history.
.SH SEE ALSO
.BR mpv (1),
.BR fzf (1),
.BR peerflix (1)
.SH AUTHOR
seri-cli contributors
MANPAGE

    ok "Man page installed (man seri-cli)"
}

install_shell_completion() {
    # bash completion
    local bash_comp="/usr/share/bash-completion/completions/seri-cli"
    sudo mkdir -p "$(dirname "$bash_comp")"
    cat << 'COMP' | sudo tee "$bash_comp" > /dev/null
_seri_cli() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local opts="-H --history -u --update -h --help -v --version"
    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
}
complete -F _seri_cli seri-cli
COMP

    # fish completion
    local fish_comp="$HOME/.config/fish/completions/seri-cli.fish"
    mkdir -p "$(dirname "$fish_comp")"
    cat << 'FISH' > "$fish_comp"
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
    install_man_page 2>/dev/null || true
    verify

    printf "\n${CYN}${BOLD}All done!${RST}\n"
    printf "  Run ${BOLD}seri-cli --help${RST} to get started.\n"
    printf "  Run ${BOLD}seri-cli \"Breaking Bad\"${RST} to start streaming.\n\n"
}

main "$@"