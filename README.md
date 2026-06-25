# seri-cli

```
  ___  ___ _ __ (_)      ___| (_)
 / __|/ _ \ '__|| |____ / __| | |
 \__ \  __/ |   | |____| (__| | |
 |___/\___|_|   |_|     \___|_|_|
```

> **Stream series, movies & films on Linux — right from your terminal.**  
> Inspired by [ani-cli](https://github.com/pystardust/ani-cli). Built for Arch Linux and derivatives.

---

## Features

- 🔍 **Search** any show or film from **1980 → 2026** via TMDB metadata
- 📺 **TV Shows** — interactive season + episode picker
- 🎬 **Movies** — instant stream selection
- 🎚️ **Quality picker** — best / 1080p / 720p / 480p / 360p
- 🔁 **Replay** — rewatch the same episode without re-searching
- ⏭️ **Next episode** — jump straight to the next ep after playback
- 📡 **Multiple providers** — vidsrc, multiembed, vidsrc.pro
- 📝 **Watch history** — tracks everything you've watched
- 🐟 **Fish shell completion** + bash completion included
- ⚡ **yt-dlp integration** — better quality extraction when available

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

### AUR (coming soon)

```bash
paru -S seri-cli
# or
yay -S seri-cli
```

---

## Dependencies

| Package | Required | Notes |
|---------|----------|-------|
| `curl`  | ✅ Yes | HTTP requests |
| `mpv`   | ✅ Yes | Video playback |
| `fzf`   | ✅ Yes | Interactive menus |
| `jq`    | ✅ Yes | JSON parsing |
| `yt-dlp` | ⚡ Optional | Better quality extraction |

Install all on Arch:

```bash
sudo pacman -S curl mpv fzf jq yt-dlp
```

---

## Usage

```
seri-cli [OPTIONS] [QUERY]

OPTIONS
  -q, --quality          Select stream quality interactively
  -p, --provider         Switch streaming provider
  -H, --history          Show watch history
  -u, --update           Update seri-cli to latest version
  -h, --help             Show this help
  -v, --version          Show version
```

### Examples

```bash
# Search for a TV show
seri-cli "Breaking Bad"

# Stream a movie
seri-cli "The Dark Knight"

# Pick quality before streaming
seri-cli -q "Chernobyl"

# Switch provider
seri-cli -p

# Show watch history
seri-cli -H

# Interactive search (no args)
seri-cli
```

---

## Workflow

```
seri-cli "query"
    │
    ├─► fzf menu: pick movie or show
    │
    ├─► fzf menu: pick quality
    │
    ├─► [TV] fzf menu: pick season → episode
    │
    ├─► extract stream URL (via yt-dlp or direct embed)
    │
    └─► MPV plays the video
         │
         └─► [TV] after playback: Replay / Next ep / Different ep / Quit
```

---

## Configuration

Config file: `~/.config/seri-cli/config`

```bash
# Override defaults
PROVIDER=vidsrc        # vidsrc | vidsrcpro | multiembed
QUALITY=best           # best | 1080p | 720p | 480p | 360p
PLAYER=mpv
TMDB_KEY=your_key_here # optional: your own TMDB API key
```

---

## Providers

| Name | URL | Notes |
|------|-----|-------|
| `vidsrc` | vidsrc.to | Default, wide coverage |
| `multiembed` | multiembed.mov | Fallback option |
| `vidsrcpro` | vidsrc.pro | Alternative source |

Switch provider mid-session: `seri-cli -p`

---

## History

Watch history is stored at:
```
~/.local/share/seri-cli/history
```

Format: `type|tmdb_id|title[|SxEy]`

View it: `seri-cli -H`

---

## Update

```bash
seri-cli -u
# or
curl -fsSL https://raw.githubusercontent.com/lain-iwakura-exe/seri-cli/main/install.sh | bash
```

---

## How it works

1. **Search** — queries the TMDB API for matching movies/shows (covers 1980–2026)
2. **Select** — `fzf` lets you pick from results with type/year info
3. **Stream URL** — constructs an embed URL for the chosen provider
4. **Extract** — `yt-dlp` extracts the direct stream (m3u8/mp4) if available; otherwise MPV handles the embed directly
5. **Play** — MPV launches with position-saving and resume support

---

## Troubleshooting

**No results found**  
→ Check your internet connection. TMDB API must be reachable.

**MPV opens but no video**  
→ Try switching provider: `seri-cli -p`  
→ Install yt-dlp: `sudo pacman -S yt-dlp`

**Quality option has no effect**  
→ yt-dlp is needed for quality filtering: `sudo pacman -S yt-dlp`

**Stream URL not extractable**  
→ Some providers block yt-dlp. Try `multiembed` as provider.

---

## License

GPL-3.0 — same as ani-cli.

---

*Made with 💙 for Linux terminal users. Arch btw.*
