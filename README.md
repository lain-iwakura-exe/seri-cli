# seri-cli

```
  ___  ___  _ __  __     __ ___  __    __
 / __|/ _ \| '__| \ \   / // _ \ \ \  / /
 \__ \  __/| |     \ \ / /| (_) | \ \/ /
 |___/\___||_|      \_/  \___/   \__/
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
| `curl` | ✅ Yes | HTTP requests |
| `mpv` | ✅ Yes | Video playback |
| `fzf` | ✅ Yes | Interactive menus |
| `jq` | ✅ Yes | JSON parsing |
| `python3` | ✅ Yes | URL encoding |
| `aria2c` | ✅ Yes | BitTorrent download engine |

> ❌ Stremio — NOT required  
> ❌ peerflix — NOT required  
> ❌ webtorrent — NOT required  
> ❌ torrentflix — NOT required  
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
```

---

## How it works

1. Search TMDB for your title (movies & shows 1980-2026)
2. Get the IMDB ID automatically
3. Query **Torrentio** for stream sources
4. Pick best quality (1080p preferred)
5. **aria2c** downloads the torrent to disk
6. Once enough has buffered, **MPV** opens automatically and plays the file
7. Download continues in the background while you watch

---

## A note on network restrictions

Some ISPs (notably in Egypt and other regions) throttle or block BitTorrent
protocol traffic, even though regular web traffic works fine. If streams
consistently show 0 peers regardless of title popularity, this is likely
the cause. A VPN typically resolves this.

---

## Troubleshooting

**MPV does not open**
→ Make sure aria2c is installed: `sudo apt install aria2` (or pacman/dnf/zypper equivalent)  
→ Wait up to 20 seconds for the download to gain enough buffer

**No streams found / 0 peers on every title**
→ This usually means your ISP is blocking BitTorrent traffic — try a VPN

**fzf menu is empty**
→ Check your internet connection

**Permission denied**
→ `sudo chmod +x /usr/local/bin/seri-cli`

---

## Config

`~/.config/seri-cli/config`
```bash
TMDB_KEY=your_key_here       # optional: your own TMDB API key
QUALITY=best                 # best | 1080p | 720p | 480p | 360p
DOWNLOAD_DIR=/tmp/seri-cli-downloads
```

---

## License

GPL-3.0 — same as ani-cli.

---

*Made for Linux terminal users. Inspired by ani-cli.*
