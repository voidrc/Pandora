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
LOCAL="$HOME/.local"
BACKUPS="../BackUps"
DRY_RUN=false
SKIP_CONFIRM=false

# Extended trash list - add your demo directories here
declare -a TRASH=(
  "$CONF/hypr/hyprland/keybinds.conf"
  "$CONF/fish/config.fish"
)

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --yes)
      SKIP_CONFIRM=true
      shift
      ;;
    *)
      error "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Cleanup function with safety checks
clean_trash() {
  info "Cleaning unnecessary configurations..."
  local deleted=0 skipped=0 errors=0

  for path in "${TRASH[@]}"; do
    if [[ ! -e "$path" ]]; then
      ((skipped++))
      continue
    fi

    if $DRY_RUN; then
      info "[DRY RUN] Would delete: ${path/#$HOME\//~\/}"
      ((deleted++))
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
  echo -e "\n${CYAN}Cleanup Summary:${NC}"
  echo -e "• ${GREEN}Deleted: $deleted items${NC}"
  echo -e "• ${YELLOW}Skipped: $skipped (not found)${NC}"
  [[ $errors -gt 0 ]] && echo -e "• ${RED}Errors: $errors failures${NC}"
  
  return $errors
}

# Backup restoration with verification
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
  local rsync_available=$(command -v rsync &>/dev/null && echo true || echo false)
  
  if $DRY_RUN; then
    info "[DRY RUN] Would restore:"
    find "$BACKUPS" -mindepth 1 -maxdepth 1 | while read -r item; do
      info "  ~> ${item/#$BACKUPS\//}"
    done
    return 0
  fi

  # Use rsync if available, otherwise cp
  if $rsync_available; then
    info "Using rsync for restoration..."
    if rsync -avh --progress "$BACKUPS"/ "$HOME"/; then
      restored=$(find "$BACKUPS" -mindepth 1 | wc -l)
    else
      errors=1
    fi
  else
    warning "rsync not found, using cp (may be slower)"
    if cp -vr "$BACKUPS"/* "$HOME"/; then
      restored=$(find "$BACKUPS" -mindepth 1 | wc -l)
    else
      errors=1
    fi
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
  
  if $DRY_RUN; then
    info "[DRY RUN] Would run: chown -R $USER:$USER $HOME"
    return 0
  fi

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
  echo -e "\n${YELLOW}🗺️ dotmap — Reconfiguring Reality${NC}"
  
  # Confirmation prompt
  if ! $SKIP_CONFIRM && ! $DRY_RUN; then
    warning "This will PERMANENTLY delete configuration files and restore backups"
    read -rp "Are you sure you want to continue? (y/N): " confirm
    [[ "${confirm,,}" != "y" ]] && exit 0
  fi

  # Execute operations
  clean_trash
  restore_backups
  fix_permissions

  echo -e "\n${GREEN}✅ dotmap — Reality reconfigured to your will${NC}"
}

# Execute main function
main
