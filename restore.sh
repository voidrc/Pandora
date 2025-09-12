#!/usr/bin/env bash

# -e: Exit immediately on error
# -u: Treat unset variables as error
# -o pipefail: Pipeline fails if any command fails
set -euo pipefail

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Enhanced logging functions
info() { echo -e "${CYAN}[ℹ] $1${NC}"; }
success() { echo -e "${GREEN}[✓] $1${NC}"; }
warning() { echo -e "${YELLOW}[⚠] $1${NC}" >&2; }
error() { echo -e "${RED}[✗] $1${NC}" >&2; }

# Check and cache sudo credentials
check_sudo() {
    info "Checking sudo privileges..."
    sudo -v || {
        error "Failed to obtain sudo privileges"
        exit 1
    }
    # Refresh sudo credentials in background
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}


# Verify required commands
check_dependencies() {
    local packages_to_install=()
    
    # Check for paru (not allowed)
    if command -v paru &>/dev/null; then
        warning "paru detected...  yay is required!!!"
        exit 1
    fi
    
    # Check for yay
    if ! command -v yay &>/dev/null; then
        packages_to_install+=("yay")
    fi
    
    # Check for rsync
    if ! command -v rsync &>/dev/null; then
        packages_to_install+=("rsync")
    fi
    
    # Install queued packages if any
    if [[ ${#packages_to_install[@]} -gt 0 ]]; then
        info "Installing missing packages: ${packages_to_install[*]}"
        sudo pacman -S --needed --noconfirm "${packages_to_install[@]}"
        success "Dependencies installed successfully"
    else
        info "All dependencies are already installed"
    fi
}

# BlackArch integration for CyberSec tools
blackarch() {
    # needs to check if blackarch repo is already installed
    if ! grep -q "blackarch" /etc/pacman.conf; then
        error "blackarch is required but not installed"
        # ask if repo is wanted
        read -rp $'\n\e[1;33mInstall BlackArch repo? (Y/n): \e[0m' choice
        if [[ ! "${choice,,}" =~ ^n ]]; then
            curl -O https://blackarch.org/strap.sh
            chmod +x ./strap.sh
            sudo ./strap.sh
            success "BlackArch repo installed successfully"
        else
            error "BlackArch repo not installed"
            exit 1
        fi
    fi
}

# Main execution flow
main() {
    # Initial checks
    check_sudo

    # Check AUR
    check_dependencies
    blackarch

    # Run packages script
    info "Running packages script..."
    "./Scripts/packages.sh" || {
        error "Packages script failed"
        exit 1
    }

    # Run dots script
    info "Running dots script..."
    "./Scripts/dots.sh" || {
        error "Dots script failed"
        exit 1
    }

    success "System restoration complete!"
    
    # Reboot prompt
    read -rp $'\n\e[1;33mReboot now? (Y/n): \e[0m' choice
    if [[ ! "${choice,,}" =~ ^n ]]; then
        info "Rebooting system..."
        sudo reboot
    else
        warning "Manual reboot required for changes to take effect"
    fi
}

# Start main function
main