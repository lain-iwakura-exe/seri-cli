# seri-cli

```
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
```

> **Stream movies & TV series from your terminal on Linux — inspired by ani-cli**  
> Uses Torrentio + peerflix + MPV. No browser needed.

---

## Features

- Search any movie or show from 1980 to 2026 via TMDB
- TV Shows with season and episode picker
- Movies instant stream
- Quality picker — 1080p preferred automatically
- Replay, Next episode, Different episode menu after playback
- Watch history
- Works on Arch, Debian, Fedora, openSUSE and any Linux distro

---

## Dependencies

### Arch / CachyOS / EndeavourOS / Manjaro
```bash
sudo pacman -S curl mpv fzf jq python nodejs npm
sudo npm install -g peerflix
```

### Debian / Ubuntu / Linux Mint
```bash
sudo apt install curl mpv fzf jq python3 nodejs npm
sudo npm install -g peerflix
```

### Fedora
```bash
sudo dnf install curl mpv fzf jq python3 nodejs npm
sudo npm install -g peerflix
```

### openSUSE
```bash
sudo zypper install curl mpv fzf jq python3 nodejs npm
sudo npm install -g peerflix
```

| Package | Required | Purpose |
|---------|----------|---------|
| curl | Yes | HTTP requests |
| mpv | Yes | Video playback |
| fzf | Yes | Interactive menus |
| jq | Yes | JSON parsing |
| python3 | Yes | URL encoding |
| nodejs + npm | Yes | Required for peerflix |
| peerflix | Yes | Torrent streaming to MPV |

---

## Install

### One-liner
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
  -u, --update      Update seri-cli
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

1. Search TMDB for your title
2. Get the IMDB ID automatically
3. Query Torrentio for stream sources
4. Pick best quality (1080p preferred)
5. peerflix serves the torrent on localhost:8888
6. MPV opens and plays the stream automatically

---

## Troubleshooting

**MPV does not open / 0 peers on every title**
Your ISP may be blocking BitTorrent traffic. Use a VPN.

**No streams found**
Try searching with the year: seri-cli "Fight Club 1999"

**Permission denied**
sudo chmod +x /usr/local/bin/seri-cli

---

## License

GPL-3.0

---

*Made for Linux terminal users. Inspired by ani-cli.*
