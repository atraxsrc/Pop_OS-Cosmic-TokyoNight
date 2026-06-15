#!/bin/bash
set -eo pipefail

# ─────────────────────────────────────────────
#  Tokyo Night Dark palette
#  bg:      #1a1b26   fg:      #c0caf5
#  cyan:    #7dcfff   blue:    #7aa2f7
#  purple:  #bb9af7   green:   #9ece6a
#  yellow:  #e0af68   orange:  #ff9e64
#  red:     #f7768e   comment: #565f89
# ─────────────────────────────────────────────

# Tokyo Night Dark — using $'...' so escape bytes are stored at assignment time
# and work correctly with both echo -e and printf "%s"
CYAN=$'\033[38;2;125;207;255m'    # #7dcfff  – section headers
BLUE=$'\033[38;2;122;162;247m'    # #7aa2f7  – info / commands
PURPLE=$'\033[38;2;187;154;247m'  # #bb9af7  – highlights
GREEN=$'\033[38;2;158;206;106m'   # #9ece6a  – success
YELLOW=$'\033[38;2;224;175;104m'  # #e0af68  – warnings
ORANGE=$'\033[38;2;255;158;100m'  # #ff9e64  – skipped
RED=$'\033[38;2;247;118;142m'     # #f7768e  – errors
DIM=$'\033[38;2;86;95;137m'       # #565f89  – comments / dim text
BOLD=$'\033[1m'
RESET=$'\033[0m'

# ── Helpers ────────────────────────────────────────────────────────────────────

print_header() {
    echo
    echo -e "${CYAN}${BOLD}┌─ $1 ${DIM}──────────────────────────────────────${RESET}"
}

print_success() { echo -e "  ${GREEN}✓ $1${RESET}"; }
print_info()    { echo -e "  ${BLUE}→ $1${RESET}"; }
print_warn()    { echo -e "  ${YELLOW}⚠ $1${RESET}"; }
print_skip()    { echo -e "  ${ORANGE}⊘ $1${RESET}"; }
print_error()   { echo -e "  ${RED}✗ $1${RESET}"; }
print_dim()     { echo -e "  ${DIM}$1${RESET}"; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

# Yes/No prompt → returns 0 for yes, 1 for no.
# Non-interactive (cron, curl | bash) defaults to "no" so heavy tasks never
# run unattended.
confirm() {
    local prompt="$1" reply
    if [ ! -t 0 ]; then
        return 1
    fi
    read -rp "$(echo -e "  ${PURPLE}${BOLD}?${RESET} ${prompt} ${DIM}[y/N]${RESET} ")" reply
    case "${reply,,}" in
        y|yes) return 0 ;;
        *)     return 1 ;;
    esac
}

# ── Update functions ───────────────────────────────────────────────────────────

update_system() {
    print_header "System Packages"

    if command_exists nala; then
        print_info "Package manager: nala"
        sudo nala update
        sudo nala upgrade --full -y
        sudo nala autoremove -y
        sudo nala clean
        print_success "Nala system update complete"

    elif command_exists apt; then
        print_info "Package manager: apt (nala not found)"
        sudo apt update
        sudo apt full-upgrade -y
        sudo apt autoremove -y
        sudo apt autoclean
        print_success "APT system update complete"

    else
        print_error "No supported package manager found — skipping"
        return 1
    fi
}

update_flatpak() {
    print_header "Flatpak"

    if ! command_exists flatpak; then
        print_skip "Flatpak not installed — skipping"
        return 0
    fi

    print_info "Running flatpak update..."
    local output exit_code
    output=$(flatpak update -y 2>&1) || true
    exit_code=$?
    while IFS= read -r line; do
        echo -e "  ${DIM}${line}${RESET}"
    done <<< "$output"

    if echo "$output" | grep -q "Nothing to do"; then
        print_success "All Flatpaks are already up to date"
    elif [ "$exit_code" -eq 0 ]; then
        print_success "Flatpak updates applied"
        print_dim "(EOL runtime warnings above are normal)"
    else
        print_warn "Flatpak finished with warnings — see output above"
    fi
}

update_snap() {
    print_header "Snap"

    if ! command_exists snap; then
        print_skip "Snap not installed — skipping"
        return 0
    fi

    print_info "Running snap refresh..."
    local output
    output=$(sudo snap refresh 2>&1) || true
    while IFS= read -r line; do
        echo -e "  ${DIM}${line}${RESET}"
    done <<< "$output"

    if echo "$output" | grep -q "All snaps up to date"; then
        print_success "All snaps are already up to date"
    else
        print_success "Snap updates applied"
    fi
}

update_firmware() {
    print_header "Firmware"

    local found=0

    # ── LVFS firmware via fwupd ──────────────────────────────────────────────
    if command_exists fwupdmgr; then
        found=1
        print_info "Refreshing firmware metadata (fwupd)..."
        # refresh exits non-zero when the cached metadata is still fresh — that's fine.
        # Output is shown live so you can see download progress.
        sudo fwupdmgr refresh --force || true

        print_info "Checking for firmware updates..."
        local updates
        updates=$(fwupdmgr get-updates 2>&1) || true   # exits non-zero when nothing to do
        while IFS= read -r line; do
            echo -e "  ${DIM}${line}${RESET}"
        done <<< "$updates"

        if echo "$updates" | grep -qiE "No updates available|No updatable devices|No available firmware"; then
            print_success "fwupd: firmware is up to date"
        else
            print_warn "fwupd: updates available — applying"
            print_dim "A reboot may be required to finish flashing."
            echo
            # Run directly (no capture) so fwupd's own live progress is visible
            if sudo fwupdmgr update -y; then
                echo
                print_success "fwupd: updates applied — reboot to finish flashing"
            else
                echo
                print_warn "fwupd: finished with warnings — a reboot may be required"
            fi
        fi
    fi

    # ── System76 hardware firmware ───────────────────────────────────────────
    # Not auto-flashed on purpose: scheduling reboots into a dedicated firmware
    # flasher, which shouldn't happen unattended in the middle of this script.
    if command_exists system76-firmware-cli; then
        found=1
        print_info "System76 firmware tool detected"
        print_dim "Hardware firmware isn't auto-flashed (it reboots into a flasher)."
        print_dim "Run ${BLUE}sudo system76-firmware-cli schedule${DIM} then reboot to apply."
    fi

    if [ "$found" -eq 0 ]; then
        print_skip "No firmware tools found (fwupd / system76-firmware-cli) — skipping"
    fi
}

update_recovery() {
    print_header "Recovery Partition"

    if ! command_exists pop-upgrade; then
        print_skip "pop-upgrade not installed — skipping"
        return 0
    fi

    print_info "Refreshing recovery partition..."
    print_dim "This re-downloads the recovery image and can take several minutes."
    echo

    local tmp exit_code
    tmp=$(mktemp)
    # Stream pop-upgrade's output live (via tee) so download progress is visible,
    # while also capturing a copy to detect the "no recovery partition" case.
    if sudo pop-upgrade recovery upgrade from-release 2>&1 | tee "$tmp"; then
        exit_code=0
    else
        exit_code=${PIPESTATUS[0]}
    fi
    echo

    if [ "$exit_code" -eq 0 ]; then
        print_success "Recovery partition updated"
    elif grep -qiE "no recovery|not found|does not exist" "$tmp"; then
        print_skip "No recovery partition detected — skipping"
    else
        print_warn "Recovery update finished with warnings — see output above"
    fi
    rm -f "$tmp"
}

# COSMIC logo accent colors — global scope so $'...' escapes work correctly
TEAL=$'\033[38;2;78;205;196m'   # #4ecdc4  COSMIC teal
ORG=$'\033[38;2;255;107;53m'    # #ff6b35  COSMIC orange

# ── Logo ───────────────────────────────────────────────────────────────────────

print_logo() {
    local P="${CYAN}${BOLD}"
    local R="${RESET}"

    echo
    printf "%s  ██╗      █████╗  ██████╗  ███████╗%s\n" "$P" "$R"
    printf "%s  ██║     ██╔══██╗ ██╔══██╗ ██╔════╝%s\n" "$P" "$R"
    printf "%s  ██║     ███████║ ██████╔╝ ███████╗%s\n"  "$P" "$R"
    printf "%s  ██║     ██╔══██║ ██╔══██╗ ╚════██║%s\n" "$P" "$R"
    printf "%s  ███████╗██║  ██║ ██████╔╝ ███████║%s\n"  "$P" "$R"
    printf "%s  ╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚══════╝%s\n" "$P" "$R"
    echo
    printf "  ${TEAL}━━━━━━━━━━━${ORG}━━━━━━━━━━━${RESET}${DIM}  Pop!_OS · COSMIC DE · System Update${RESET}\n"
    printf "  ${DIM}  $(date '+%A %d %B %Y  %H:%M:%S')${RESET}\n"
    echo
}

# ── Main ───────────────────────────────────────────────────────────────────────

main() {
    local start_time end_time duration
    local do_firmware=false do_recovery=false

    print_logo

    # Ask the optional, heavier tasks up front so the rest can run unattended.
    if confirm "Update firmware (fwupd / System76)?"; then
        do_firmware=true
    fi
    if confirm "Update recovery partition? (re-downloads recovery image)"; then
        do_recovery=true
    fi

    start_time=$(date +%s)

    update_system || {
        print_error "System package update failed — continuing with remaining tasks"
    }

    update_flatpak
    update_snap

    if [ "$do_firmware" = true ]; then
        update_firmware
    else
        print_header "Firmware"
        print_skip "Skipped (not selected)"
    fi

    if [ "$do_recovery" = true ]; then
        update_recovery
    else
        print_header "Recovery Partition"
        print_skip "Skipped (not selected)"
    fi

    end_time=$(date +%s)
    duration=$((end_time - start_time))

    echo
    echo -e "${CYAN}${BOLD}└─ All done ${DIM}──────────────────────────────────${RESET}"
    printf "   ${GREEN}✓ Completed in ${BOLD}%dm %ds${RESET}\n" \
        $((duration / 60)) $((duration % 60))
    echo
}

main