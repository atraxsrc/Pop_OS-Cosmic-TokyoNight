# 🌃 Pop!_OS · COSMIC · Tokyo Night

> My personal desktop setup running **Pop!_OS 24.04 LTS** with the **COSMIC DE** and **Tokyo Night Dark** theming throughout — terminal, fastfetch, scripts, dotfiles, and wallpapers all in one place.

![Pop!_OS](https://img.shields.io/badge/Pop!_OS-24.04_LTS-48B9C7?style=for-the-badge&logo=popos&logoColor=white)
![COSMIC](https://img.shields.io/badge/COSMIC-1.0.0-ff6b35?style=for-the-badge)
![Tokyo Night](https://img.shields.io/badge/Theme-Tokyo_Night_Dark-7aa2f7?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-9ece6a?style=for-the-badge)

---
## 🖼️ Wallpapers

> I maintain a dedicated Tokyo Night wallpaper collection with 60+ wallpapers over at:
> **[tokyonight-wallpapers](https://github.com/atraxsrc/tokyonight-wallpapers)** ⭐

---
## 📸 Screenshots

<img width="3840" height="2160" alt="miage" src="https://github.com/user-attachments/assets/374fce9f-c470-4487-a4d6-e59749434398" />


---
## 🖥️ Hardware

| Component | Spec |
|-----------|------|
| **Machine** | Lenovo ThinkPad (21CKCTO1WW) |
| **CPU** | AMD Ryzen 7 PRO 6850U |
| **GPU** | AMD Radeon 680M (integrated) |
| **RAM** | 30.12 GiB |
| **Storage** | 906.94 GiB |

---

## 🗂️ Repo Structure

```
├── dotfiles              
|   ├── .zshrc            # Zsh configuration
├── fastfetch
│   ├── config.jsonc      # Fastfetch configuration
│   ├── cosmicTN.txt
│   └── cosmic.txt
├── LICENSE
├── README.md
├── screenshots           # Desktop screenshots
│   ├── cosmicfinal.png
│   └── miage.png
└── scripts
    └── update_system.sh  # System update script (nala + flatpak + snap)
```

---

## ⚡ Scripts

### `update.sh`

A full system update script with Tokyo Night colored output. Handles:

- **nala** package updates (with apt fallback)
- **Flatpak** updates
- **Snap** updates (if installed)
- Runtime timer and status indicators

```bash
# Make executable and run
chmod +x scripts/update.sh
sudo ./scripts/update.sh
```

---

## 🎨 Theme

Everything is themed around **Tokyo Night Dark** — a low-contrast, dark blue palette originally from the VSCode theme by the same name.

| Role | Color | Hex |
|------|-------|-----|
| Background | ![#1a1b26](https://placehold.co/12x12/1a1b26/1a1b26.png) Dark Navy | `#1a1b26` |
| Foreground | ![#c0caf5](https://placehold.co/12x12/c0caf5/c0caf5.png) Soft White | `#c0caf5` |
| Cyan | ![#7dcfff](https://placehold.co/12x12/7dcfff/7dcfff.png) Sky Blue | `#7dcfff` |
| Blue | ![#7aa2f7](https://placehold.co/12x12/7aa2f7/7aa2f7.png) Periwinkle | `#7aa2f7` |
| Purple | ![#bb9af7](https://placehold.co/12x12/bb9af7/bb9af7.png) Lavender | `#bb9af7` |
| Green | ![#9ece6a](https://placehold.co/12x12/9ece6a/9ece6a.png) Sage | `#9ece6a` |
| Yellow | ![#e0af68](https://placehold.co/12x12/e0af68/e0af68.png) Amber | `#e0af68` |
| Red | ![#f7768e](https://placehold.co/12x12/f7768e/f7768e.png) Rose | `#f7768e` |

---

## 🚀 Setup

### Prerequisites

```bash
# Install nala (better apt frontend)
sudo apt install nala

# Install fastfetch
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo nala update && sudo nala install fastfetch
```

### Apply dotfiles

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/Pop_OS-Cosmic-TokyoNight.git
cd Pop_OS-Cosmic-TokyoNight

# Copy zshrc
cp dotfiles/.zshrc ~/.zshrc

# Copy fastfetch config
mkdir -p ~/.config/fastfetch
cp fastfetch/config.jsonc ~/.config/fastfetch/
```
---

## 🛠️ Stack

| Tool | What it does |
|------|-------------|
| [Pop!_OS 24.04](https://pop.system76.com/) | Base OS by System76 |
| [COSMIC DE](https://system76.com/cosmic) | Desktop environment (Rust + Iced) |
| [Tokyo Night](https://github.com/tokyo-night/tokyo-night-vscode-theme) | Color scheme |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | System info fetcher |
| [nala](https://gitlab.com/volian/nala) | Better apt frontend |
| [zsh](https://www.zsh.org/) | Shell |

---

## 📄 License

MIT — do whatever you want with it. Attribution appreciated but not required.

---

<div align="center">
  <sub>Built on Pop!_OS 24.04 · COSMIC 1.0.0 · Tokyo Night Dark</sub>
</div>
