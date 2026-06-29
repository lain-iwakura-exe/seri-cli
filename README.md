# seri-cli

```
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
```

> **Stream movies & TV series from your terminal on Linux — inspired by ani-cli**  
> Uses Torrentio + MPV. No Stremio required. No browser needed.

---

## Features

- 🔍 Search any movie or show from **1980 → 2026** via TMDB
- 📺 TV Shows — season + episode picker with episode names
- 🎬 Movies — instant stream
- 🎚️ Quality picker — 1080p preferred automatically
- 🔁 Replay / Next episode / Different episode menu
- 📝 Watch history
- ⚡ Streams via Torrentio (torrent-based, always working)
- 🐧 Works on Arch, Debian, Fedora, openSUSE and any Linux distro

---

## Dependencies

Install these before installing seri-cli:

### Arch / CachyOS / EndeavourOS / Manjaro
```bash
sudo pacman -S curl mpv fzf jq python nodejs npm
sudo npm install -g peerflix webtorrent-cli
```

### Debian / Ubuntu / Linux Mint
```bash
sudo apt install curl mpv fzf jq python3 nodejs npm
sudo npm install -g peerflix webtorrent-cli
```

### Fedora
```bash
sudo dnf install curl mpv fzf jq python3 nodejs npm
sudo npm install -g peerflix webtorrent-cli
```

### openSUSE
```bash
sudo zypper install curl mpv fzf jq python3 nodejs npm
sudo npm install -g peerflix webtorrent-cli
```

| Package | Required | Purpose |
|---------|----------|---------|
| `curl` | ✅ Yes | HTTP requests |
| `mpv` | ✅ Yes | Video playback |
| `fzf` | ✅ Yes | Interactive menus |
| `jq` | ✅ Yes | JSON parsing |
| `python3` | ✅ Yes | URL encoding |
| `nodejs` + `npm` | ✅ Yes | Required for torrent streaming |
| `peerflix` | ✅ Yes | Torrent streaming to MPV |
| `webtorrent-cli` | ⚡ Recommended | Faster than peerflix |
| `yt-dlp` | ⚡ Optional | Direct stream fallback |

> ❌ Stremio — NOT required  
> ❌ Stremio account — NOT required  
> ❌ Any browser — NOT required

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
seri-cli "Dune"
```

---

## How it works

1. Search TMDB for your title (movies & shows 1980–2026)
2. Get the IMDB ID automatically
3. Query **Torrentio** for stream sources
4. Pick best quality (1080p BluRay preferred)
5. Stream in **MPV** via webtorrent or peerflix

---

## Troubleshooting

**MPV doesn't open**
→ Wait 20-30 seconds — peerflix buffers before launching MPV  
→ Or install webtorrent (faster): `sudo npm install -g webtorrent-cli`

**No streams found**
→ Try a more popular title first  
→ Check internet connection

**fzf menu is empty**
→ Check your internet connection (TMDB must be reachable)

**Permission denied**
→ `sudo chmod +x /usr/local/bin/seri-cli`

---

## Config

`~/.config/seri-cli/config`
```bash
TMDB_KEY=your_key_here   # optional: your own TMDB API key
QUALITY=best             # best | 1080p | 720p | 480p | 360p
```

---

## License

GPL-3.0 — same as ani-cli.

---

*Made for Linux terminal users. Inspired by ani-cli.*
