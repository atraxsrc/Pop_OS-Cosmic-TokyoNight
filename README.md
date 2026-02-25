# 🌃 Pop!_OS · COSMIC · Tokyo Night

> My personal desktop setup running **Pop!_OS 24.04 LTS** with the **COSMIC DE** and **Tokyo Night Dark** theming throughout — terminal, fastfetch, scripts, dotfiles, and wallpapers all in one place.

![Pop!_OS](https://img.shields.io/badge/Pop!_OS-24.04_LTS-48B9C7?style=for-the-badge&logo=popos&logoColor=white)
![COSMIC](https://img.shields.io/badge/COSMIC-1.0.0-ff6b35?style=for-the-badge)
![Tokyo Night](https://img.shields.io/badge/Theme-Tokyo_Night_Dark-7aa2f7?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-9ece6a?style=for-the-badge)

---

## 📸 Screenshots

<img width="3840" height="2160" alt="miage" src="https://github.com/user-attachments/assets/374fce9f-c470-4487-a4d6-e59749434398" />


---
🖼️ Wallpapers

I maintain a dedicated Tokyo Night wallpaper collection with many wallpapers over at:
[tokyonight-wallpapers](https://github.com/atraxsrc/tokyonight-wallpapers) ⭐

🖥️ Hardware
ComponentSpecMachineLenovo ThinkPad (21CKCTO1WW)CPUAMD Ryzen 7 PRO 6850UGPUAMD Radeon 680M (integrated)RAM30.12 GiBStorage906.94 GiB

🗂️ Repo Structure
Pop_OS-Cosmic-TokyoNight/
├── README.md
├── scripts/
│   └── update.sh          # System update script (nala + flatpak)
├── fastfetch/
│   └── config.jsonc       # Fastfetch configuration
├── dotfiles/
│   └── .zshrc             # Zsh configuration
└── screenshots/           # Desktop screenshots

⚡ Scripts
update.sh
A full system update script with Tokyo Night colored output. Handles:

nala package updates (with apt fallback)
Flatpak updates
Snap updates (if installed)
Runtime timer and status indicators

bash# Make executable and run
chmod +x scripts/update.sh
sudo ./scripts/update.sh

🎨 Theme
Everything is themed around Tokyo Night Dark — a low-contrast, dark blue palette originally from the VSCode theme by the same name.
RoleColorHexBackgroundShow Image Dark Navy#1a1b26ForegroundShow Image Soft White#c0caf5CyanShow Image Sky Blue#7dcfffBlueShow Image Periwinkle#7aa2f7PurpleShow Image Lavender#bb9af7GreenShow Image Sage#9ece6aYellowShow Image Amber#e0af68RedShow Image Rose#f7768e

🚀 Setup
Prerequisites
bash# Install nala (better apt frontend)
sudo apt install nala

# Install fastfetch
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo nala update && sudo nala install fastfetch
Apply dotfiles
bash# Clone the repo
git clone https://github.com/YOUR_USERNAME/Pop_OS-Cosmic-TokyoNight.git
cd Pop_OS-Cosmic-TokyoNight

# Copy zshrc
cp dotfiles/.zshrc ~/.zshrc

# Copy fastfetch config
mkdir -p ~/.config/fastfetch
cp fastfetch/config.jsonc ~/.config/fastfetch/

🛠️ Stack
ToolWhat it doesPop!_OS 24.04Base OS by System76COSMIC DEDesktop environment (Rust + Iced)Tokyo NightColor schemefastfetchSystem info fetchernalaBetter apt frontendzshShell

📄 License
MIT — do whatever you want with it. Attribution appreciated but not required.

<div align="center">
  <sub>Built on Pop!_OS 24.04 · COSMIC 1.0.0 · Tokyo Night Dark</sub>
</div>
