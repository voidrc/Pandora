#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# dotmap — Bend the world to your will
# 
# Cleans unnecessary configs and restores backups
# ---------------------------------------------------------------------------

# Exit on error, unset variable, and pipe failure
set -euo pipefail

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
info() { echo -e "${CYAN}[ℹ] $1${NC}"; }
success() { echo -e "${GREEN}[✓] $1${NC}"; }
warning() { echo -e "${YELLOW}[⚠] $1${NC}"; }
error() { echo -e "${RED}[✗] $1${NC}" >&2; }

# Configuration
CONF="$HOME/.config"
BACKUPS="../BackUps"

# Files to delete
declare -a TRASH=(
  "$CONF/hypr/hyprland/keybinds.conf"
  "$CONF/fish/config.fish"
)

# Cleanup function
clean_trash() {
  info "Cleaning unnecessary configurations..."
  local deleted=0 skipped=0 errors=0

  for path in "${TRASH[@]}"; do
    if [[ ! -e "$path" ]]; then
      ((skipped++))
      continue
    fi

    if rm -rf "$path" 2>/dev/null; then
      info "Deleted: ${path/#$HOME\//~\/}"
      ((deleted++))
    else
      error "Failed to delete: ${path/#$HOME\//~\/}"
      ((errors++))
    fi
  done

  # Summary
  echo
  info "Cleanup Summary:"
  success "Deleted: $deleted items"
  warning "Skipped: $skipped (not found)"
  [[ $errors -gt 0 ]] && error "Errors: $errors failures"
  
  return $errors
}

# Backup restoration
restore_backups() {
  info "Restoring backups from: $BACKUPS"
  
  # Verify backups directory
  if [[ ! -d "$BACKUPS" ]]; then
    error "Backups directory not found: $BACKUPS"
    return 1
  fi
  
  # Check for files to restore
  if [[ -z "$(ls -A "$BACKUPS")" ]]; then
    warning "Backups directory is empty"
    return 0
  fi

  local restored=0 errors=0

  if rsync -avh --progress "$BACKUPS"/ "$HOME"/; then
    restored=$(find "$BACKUPS" -mindepth 1 | wc -l)
  else
    errors=1
  fi

  # Summary
  if [[ $errors -eq 0 ]]; then
    success "Restored $restored items"
  else
    error "Backup restoration encountered errors"
  fi
  
  return $errors
}

# Permission fix
fix_permissions() {
  info "Fixing permissions..."
  
  if sudo chown -R "$USER:$USER" "$HOME"; then
    success "Permissions fixed"
    return 0
  else
    error "Permission fix failed"
    return 1
  fi
}

# Main function
main() {  
  # Confirmation prompt
  warning "This will PERMANENTLY delete configuration files and restore backups"
  read -rp "Are you sure you want to continue? (y/N): " confirm
  [[ "${confirm,,}" != "y" ]] && exit 0

  # Execute operations
  clean_trash
  restore_backups
  fix_permissions
  success "dots restored!!!"
}

# Execute main function
main