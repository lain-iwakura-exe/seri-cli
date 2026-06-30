# seri-cli

```
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
```

> **Stream movies & TV series from your terminal on Linux — inspired by ani-cli**  
> **NO TORRENTS REQUIRED** — Direct streaming via vidsrc.to, 2embed.cc, and more!

---

## Features

- 🔍 Search any movie or show from **1980 → 2026** via TMDB
- 📺 TV Shows — season + episode picker with episode names
- 🎬 Movies — instant stream
- ⚡ **No torrents** — Direct HTTP streaming
- 🚀 Fast startup — no waiting for peers
- 📝 Watch history
- 🎯 Multiple fallback sources for reliability
- 🐧 Works on Arch, Debian, Fedora, openSUSE and any Linux distro

---

## Dependencies

**Minimal dependencies** — no npm, no nodejs, no peerflix!

### Arch / CachyOS / EndeavourOS / Manjaro
```bash
sudo pacman -S curl mpv fzf jq
# Optional: yt-dlp for better stream extraction
sudo pacman -S yt-dlp
```

### Debian / Ubuntu / Linux Mint
```bash
sudo apt install curl mpv fzf jq
# Optional: yt-dlp for better stream extraction
sudo apt install yt-dlp
```

### Fedora
```bash
sudo dnf install curl mpv fzf jq
# Optional: yt-dlp for better stream extraction
sudo dnf install yt-dlp
```

### openSUSE
```bash
sudo zypper install curl mpv fzf jq
# Optional: yt-dlp for better stream extraction
sudo zypper install yt-dlp
```

| Package | Required | Purpose |
|---------|----------|---------|
| `curl` | ✅ Yes | HTTP requests |
| `mpv` | ✅ Yes | Video playback |
| `fzf` | ✅ Yes | Interactive menus |
| `jq` | ✅ Yes | JSON parsing |
| `yt-dlp` | ⭕ Optional | Better stream extraction |

> ❌ **No torrent clients required** (no peerflix, no webtorrent, no transmission)  
> ❌ **No nodejs/npm required**  
> ❌ **No Stremio**  
> ❌ **No browser needed**

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
seri-cli "Fight Club"
seri-cli "The Lord of the Rings"
seri-cli "Pulp Fiction"
seri-cli "Game of Thrones"
```

---

## How it works

1. **Search TMDB** for your title (movies & shows 1980-2026)
2. **Select** from search results using fzf
3. **For TV shows:** choose season and episode
4. **Direct stream** from vidsrc.to, 2embed.cc, or vidplay.online
5. **MPV opens instantly** with no torrent waiting

### Stream Sources
- **vidsrc.to** — Primary (best quality, fast)
- **2embed.cc** — Backup
- **vidplay.online** — Fallback
- **yt-dlp** — If available, as last resort

---

## What's New in v5.0

### 🚀 **No More Torrents!**
- **Removed:** peerflix, nodejs, npm, Torrentio, magnet links
- **Added:** Direct HTTP streaming from multiple sources
- **Result:** Instant playback, no peer waiting, works on any network

### 📦 **Lighter Dependencies**
- Before: curl + mpv + fzf + jq + python3 + nodejs + npm + peerflix
- Now: curl + mpv + fzf + jq (optional: yt-dlp)

### ⚡ **Faster Startup**
- No waiting for peers to connect
- No buffering time
- Stream starts playing immediately

---

## Troubleshooting

**"No streams found"**
→ The source might be temporarily down. Try again in a few minutes.  
→ Install yt-dlp for better stream extraction: `sudo apt install yt-dlp`

**MPV does not open**
→ Make sure mpv is installed: `sudo apt install mpv`

**Stream is slow or buffering**
→ Try a different source (the script tries multiple automatically)  
→ Use yt-dlp for better performance

**fzf menu is empty**
→ Check your internet connection

**Permission denied**
→ `sudo chmod +x /usr/local/bin/seri-cli`

**"curl: (28) Connection timed out"**
→ Some sources might be blocked in your region. Try using a VPN.

---

## Config

`~/.config/seri-cli/config`
```bash
TMDB_KEY=your_key_here   # optional: your own TMDB API key
QUALITY=best             # best | 1080p | 720p | 480p
```

---

## Why no torrents?

| Torrents | Direct Streaming |
|----------|------------------|
| ❌ Wait for peers | ✅ Instant playback |
| ❌ DMCA issues | ✅ No sharing |
| ❌ Blocked on many networks | ✅ Works everywhere |
| ❌ Heavy dependencies | ✅ Lightweight |
| ❌ Unreliable seeders | ✅ Always available |

---

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## License

GPL-3.0 — same as ani-cli.

---

## Credits

- Inspired by [ani-cli](https://github.com/pystardust/ani-cli)
- TMDB for movie/show data
- vidsrc.to, 2embed.cc, vidplay.online for streaming

---

*Made for Linux terminal users. No browser needed. No torrents needed.*

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=lain-iwakura-exe/seri-cli&type=Date)](https://star-history.com/#lain-iwakura-exe/seri-cli&Date)

---

**Happy Streaming! 🎬**