# Tokyo Night zsh layer: colours, aliases, prompt.
#
# Source it at the END of your own ~/.zshrc, after oh-my-zsh.sh:
#   source /path/to/Pop_OS-Cosmic-TokyoNight/zsh/tokyonight.zsh
#
# Keep machine-specific or private lines (PATH, scaling, nvm, ...) in your
# own ~/.zshrc, not here.
#
#  bg:      #1a1b26   fg:      #c0caf5
#  cyan:    #7dcfff   blue:    #7aa2f7
#  purple:  #bb9af7   green:   #9ece6a
#  yellow:  #e0af68   orange:  #ff9e64
#  red:     #f7768e   comment: #565f89

# ── File colours (ls, lsd file names, completion menu) ─────────────────────────

export LS_COLORS="di=1;38;2;122;162;247:ln=38;2;125;207;255:ex=38;2;158;206;106:*.zip=38;2;247;118;142:*.tar=38;2;247;118;142:*.gz=38;2;247;118;142:*.xz=38;2;247;118;142:*.7z=38;2;247;118;142:*.deb=38;2;247;118;142:*.png=38;2;187;154;247:*.jpg=38;2;187;154;247:*.jpeg=38;2;187;154;247:*.webp=38;2;187;154;247:*.gif=38;2;187;154;247:*.mp4=38;2;255;158;100:*.mkv=38;2;255;158;100:*.rs=38;2;224;175;104:*.py=38;2;224;175;104:*.js=38;2;224;175;104:*.ts=38;2;224;175;104:*.sh=38;2;158;206;106:*.md=38;2;192;202;245:*.txt=38;2;192;202;245:or=38;2;247;118;142"

# oh-my-zsh reads LS_COLORS before this file loads, so refresh the menu colours
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ── zsh-autosuggestions / zsh-syntax-highlighting ──────────────────────────────

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[function]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#7aa2f7,underline'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#bb9af7,underline'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e'
ZSH_HIGHLIGHT_STYLES[path]='fg=#7dcfff,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#565f89'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#565f89'

# ── Aliases (only when the tool is installed) ──────────────────────────────────

if (( $+commands[lsd] )); then
    alias ls='lsd'
    alias la='lsd -a'
    alias ll='lsd -l'
    alias lla='lsd -la'
fi

# Debian/Ubuntu ship bat as batcat
if (( $+commands[batcat] )); then
    alias cat='batcat'
elif (( $+commands[bat] )); then
    alias cat='bat'
fi

(( $+commands[cosmic-edit] )) && alias edit='cosmic-edit'

if (( $+commands[nvim] )); then
    alias vi='nvim'
    alias vim='nvim'
    alias v='nvim'
fi

# ── Prompt ─────────────────────────────────────────────────────────────────────

# needs ZSH_THEME="" in ~/.zshrc
(( $+commands[starship] )) && eval "$(starship init zsh)"
