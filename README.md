# seri-cli

```
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
```

> **Stream movies & TV series from your terminal on Linux — inspired by ani-cli**  
> Uses Torrentio + MPV for real working streams. No browser needed.

---

## Features

- 🔍 Search any movie or show from **1980 → 2026** via TMDB
- 📺 TV Shows — season + episode picker with episode names
- 🎬 Movies — instant stream
- 🔁 Replay, Next episode, Different episode menu after playback
- 📝 Watch history
- ⚡ Streams via Torrentio (torrent-based, always working)
- 🐟 Fish + bash shell completions

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

## Dependencies

### Arch / CachyOS / EndeavourOS
```bash
sudo pacman -S curl mpv fzf jq python3 nodejs npm
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

| Package | Required | Purpose |
|---------|----------|---------|
| `curl` | ✅ Yes | HTTP requests |
| `mpv` | ✅ Yes | Video playback |
| `fzf` | ✅ Yes | Interactive menus |
| `jq` | ✅ Yes | JSON parsing |
| `python3` | ✅ Yes | URL encoding |
| `nodejs` + `peerflix` | ✅ Yes | Torrent streaming |
| `yt-dlp` | ⚡ Optional | Direct stream fallback |

---

## How it works

1. Search TMDB for your title
2. Get the IMDB ID
3. Query **Torrentio** (torrentio.strem.fun) for stream sources
4. Pick the best torrent stream
5. Stream directly in **MPV** via peerflix

No Stremio app required. No browser needed. Pure terminal.

---

## Usage

```
seri-cli [OPTIONS] [QUERY]

OPTIONS
  -H, --history     Watch history
  -u, --update      Update seri-cli
  -h, --help        Help
  -v, --version     Version
```

### Examples
```bash
seri-cli "Breaking Bad"
seri-cli "Interstellar"
seri-cli "The Dark Knight"
seri-cli "House of the Dragon"
```

---

## Config

`~/.config/seri-cli/config`
```bash
TMDB_KEY=your_key_here   # optional: your own TMDB API key
QUALITY=best             # best | 1080p | 720p | 480p | 360p
```

---

## Troubleshooting

**No streams found**
→ The title may not be on Torrentio yet. Try a more popular title first.

**MPV opens but no video**
→ Make sure peerflix is installed: `sudo npm install -g peerflix`

**fzf menu is empty**
→ Check your internet connection. TMDB and Torrentio must be reachable.

**Permission denied**
→ `sudo chmod +x /usr/local/bin/seri-cli`

---

## License

GPL-3.0

---

*Made for Linux terminal users. No Stremio app required.*
