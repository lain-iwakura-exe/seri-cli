# seri-cli

```
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
```

> **Stream movies & TV series from your terminal on Linux — inspired by ani-cli**  
> Downloads via aria2c (BitTorrent) and plays directly in MPV.

---

## Features

- 🔍 Search any movie or show from **1980 → 2026** via TMDB
- 📺 TV Shows — season + episode picker with episode names
- 🎬 Movies — instant stream
- 🎚️ Quality picker — 1080p preferred automatically
- 🔁 Replay / Next episode / Different episode menu
- 📝 Watch history
- ⚡ Downloads via Torrentio + aria2c, plays in MPV automatically
- 🐧 Works on Arch, Debian, Fedora, openSUSE and any Linux distro

---

## Dependencies

### Arch / CachyOS / EndeavourOS / Manjaro
```bash
sudo pacman -S curl mpv fzf jq python aria2
```

### Debian / Ubuntu / Linux Mint
```bash
sudo apt install curl mpv fzf jq python3 aria2
```

### Fedora
```bash
sudo dnf install curl mpv fzf jq python3 aria2
```

### openSUSE
```bash
sudo zypper install curl mpv fzf jq python3 aria2
```

| Package | Required | Purpose |
|---------|----------|---------|
| `curl` | Yes | HTTP requests |
| `mpv` | Yes | Video playback |
| `fzf` | Yes | Interactive menus |
| `jq` | Yes | JSON parsing |
| `python3` | Yes | URL encoding |
| `aria2c` | Yes | BitTorrent download engine |

---

## Install

### One-liner (recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/lain-iwakura-exe/seri-cli/main/install.sh | bash
```

### Manual
```bash
curl -fsSL https://raw.githubusercontent.com/lain-iwakura-exe/seri-cli/main/seri-cli \
    -o ~/.local/bin/seri-cli
chmod +x ~/.local/bin/seri-cli
```

---

## Usage

```
seri-cli [OPTIONS] [QUERY]

OPTIONS
  -H, --history     Show watch history
  -u, --update      Update seri-cli to latest version
  -h, --help        Show help
  -v, --version     Show version
```

### Examples
```bash
seri-cli "Breaking Bad"
seri-cli "Interstellar"
seri-cli "The Dark Knight"
seri-cli "House of the Dragon"
```

---

## How it works

1. Search TMDB for your title (movies and shows 1980-2026)
2. Get the IMDB ID automatically
3. Query Torrentio for stream sources
4. Pick best quality (1080p preferred)
5. aria2c downloads the torrent sequentially to disk
6. Once 20MB is buffered, MPV opens automatically and plays the file
7. Download continues in the background while you watch

---

## Note on ISP restrictions

Some ISPs throttle or block BitTorrent protocol traffic. If streams
consistently show 0 peers regardless of title, this is likely the cause.
A VPN resolves this.

---

## Troubleshooting

**MPV does not open**
Install aria2: `sudo apt install aria2` (or pacman/dnf/zypper)

**0 peers on every title**
Your ISP is blocking BitTorrent traffic. Use a VPN.

**fzf menu is empty**
Check your internet connection.

**Permission denied**
`sudo chmod +x /usr/local/bin/seri-cli`

---

## Config

`~/.config/seri-cli/config`
```bash
TMDB_KEY=your_key_here
QUALITY=best
DOWNLOAD_DIR=/tmp/seri-cli-downloads
```

---

## License

GPL-3.0

---

*Made for Linux terminal users. Inspired by ani-cli.*
