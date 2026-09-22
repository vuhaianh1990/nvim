#!/usr/bin/env bash
set -uo pipefail

DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

log() { printf "\033[1;34m[install]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[install]\033[0m %s\n" "$*"; }
run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "DRY-RUN: $*"
    return 0
  fi
  log "> $*"
  "$@"
}

need() { command -v "$1" >/dev/null 2>&1; }

OS="$(uname -s)"
DISTRO=""
PACKAGE_MANAGER=""

detect() {
  if [[ "$OS" == "Darwin" ]]; then
    if ! need brew; then
      warn "Homebrew not found. Install it with:"
      warn "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
      return 1
    fi
    PACKAGE_MANAGER="brew"
    return 0
  fi
  if [[ "$OS" != "Linux" ]]; then
    warn "Unsupported OS: $OS. Only Linux and macOS are supported."
    return 1
  fi
  DISTRO="$(. /etc/os-release 2>/dev/null && echo "${ID:-unknown}")"
  case "$DISTRO" in
    ubuntu | debian | linuxmint | pop | elementary | rasbian | kali | neon | zorin)
      PACKAGE_MANAGER="apt"
      ;;
    fedora | rhel | centos | rocky | almalinux)
      PACKAGE_MANAGER="dnf"
      ;;
    arch | manjaro | endeavour | artix | cachyos)
      PACKAGE_MANAGER="pacman"
      ;;
    opensuse* | suse)
      PACKAGE_MANAGER="zypper"
      ;;
    alpine)
      PACKAGE_MANAGER="apk"
      ;;
    *)
      warn "Unsupported or unknown distro: '$DISTRO'"
      warn "Install dependencies manually. Run :checkhealth deps for hints."
      return 1
      ;;
  esac
  return 0
}

apt_install() { run sudo apt-get update && run sudo apt-get install -y "$@" || warn "apt failed for: $*"; }
dnf_install() { run sudo dnf install -y "$@" || warn "dnf failed for: $*"; }
pacman_install() { run sudo pacman -S --needed --noconfirm "$@" || warn "pacman failed for: $*"; }
zypper_install() { run sudo zypper --non-interactive install "$@" || warn "zypper failed for: $*"; }
apk_install() { run sudo apk add --no-cache "$@" || warn "apk failed for: $*"; }
brew_install() { run brew install "$@" || warn "brew failed for: $*"; }

install_packages() {
  case "$PACKAGE_MANAGER" in
    apt) apt_install "$@" ;;
    dnf) dnf_install "$@" ;;
    pacman) pacman_install "$@" ;;
    zypper) zypper_install "$@" ;;
    apk) apk_install "$@" ;;
    brew) brew_install "$@" ;;
  esac
}

install_missing() {
  local name="$1"
  shift
  if need "$name"; then
    log "$name already installed. Skipping."
    return 0
  fi
  install_packages "$@"
}

# Some distros don't package lazygit (or the version is old).
# Fall back to the official GitHub release if the package was not found.
install_lazygit() {
  [[ "$DRY_RUN" -eq 1 ]] && { log "DRY-RUN: install lazygit"; return 0; }
  if need lazygit; then
    log "lazygit already installed. Skipping."
    return 0
  fi
  install_packages lazygit
  if need lazygit; then
    return 0
  fi
  warn "Package 'lazygit' unavailable, installing official release..."
  local tmp ver
  tmp="$(mktemp -d)"
  ver="$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name"' | sed 's/.*: *"\([^"]*\)".*/\1/' || echo "v0.44.1")"
  case "$(uname -m)" in
    aarch64 | arm64) local arch="arm64" ;;
    *) local arch="x86_64" ;;
  esac
  local tarball="lazygit_${ver#v}_Linux_${arch}.tar.gz"
  curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/${ver}/${tarball}" -o "$tmp/lazygit.tar.gz"
  sudo tar -C "$tmp" -xzf "$tmp/lazygit.tar.gz" lazygit
  sudo mv "$tmp/lazygit" /usr/local/bin/lazygit
  rm -rf "$tmp"
  log "lazygit installed to /usr/local/bin"
}

install_nvim() {
  if need nvim && nvim --version 2>/dev/null | head -1 | grep -qE "^NVIM v(0\.1[1-9]|[1-9][0-9]*)"; then
    log "Neovim >= 0.11 already installed. Skipping."
    return 0
  fi

  if [[ "$PACKAGE_MANAGER" == "brew" ]]; then
    brew_install neovim
    return 0
  fi

  case "$PACKAGE_MANAGER" in
    pacman)
      pacman_install neovim
      ;;
    apt)
      # apt Neovim is often ancient; install the official build.
      log "Installing Neovim from the official tarball (apt version is too old)."
      if [[ "$DRY_RUN" -eq 1 ]]; then
        log "DRY-RUN: download nvim-linux-x86_64 and symlink to /usr/local/bin"
        return 0
      fi
      local tmp
      tmp="$(mktemp -d)"
      curl -fsSL "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz" -o "$tmp/nvim.tar.gz"
      sudo tar -C /opt -xzf "$tmp/nvim.tar.gz"
      sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
      rm -rf "$tmp"
      ;;
    dnf | zypper | apk)
      install_missing nvim neovim
      ;;
  esac
}

main() {
  detect || exit 1

  log "Detected: $OS${DISTRO:+ ($DISTRO)} using $PACKAGE_MANAGER"

  install_nvim

  case "$PACKAGE_MANAGER" in
    apt)
      install_missing git git-core
      install_missing rg ripgrep
      install_missing fd fd-find
      install_lazygit
      install_missing node nodejs
      install_missing npm npm
      install_missing python3 python3 python3-pip
      install_missing unzip unzip
      install_missing curl curl
      install_missing wget wget
      install_missing git_lfs git-lfs
      install_missing make make
      install_missing cc build-essential
      ;;
    dnf)
      install_missing git git
      install_missing rg ripgrep
      install_missing fd fd-find
      install_lazygit
      install_missing node nodejs
      install_missing npm npm
      install_missing python3 python3 python3-pip
      install_missing unzip unzip
      install_missing curl curl
      install_missing wget wget
      install_missing git_lfs git-lfs
      install_missing make make
      install_missing cc gcc-c++
      ;;
    pacman)
      install_missing git git
      install_missing rg ripgrep
      install_missing fd fd
      install_missing lazygit lazygit
      install_missing node nodejs
      install_missing npm npm
      install_missing python3 python python-pip
      install_missing unzip unzip
      install_missing curl curl
      install_missing wget wget
      install_missing git_lfs git-lfs
      install_missing make make
      install_missing cc base-devel
      ;;
    zypper)
      install_missing git git-core
      install_missing rg ripgrep
      install_missing fd fd
      install_lazygit
      install_missing node nodejs
      install_missing npm npm
      install_missing python3 python3 python3-pip
      install_missing unzip unzip
      install_missing curl curl
      install_missing wget wget
      install_missing git_lfs git-lfs
      install_missing make make
      install_missing cc gcc gcc-c++
      ;;
    apk)
      install_missing git git
      install_missing rg ripgrep
      install_missing fd fd
      install_missing lazygit lazygit
      install_missing node nodejs
      install_missing npm npm
      install_missing python3 python3 py3-pip
      install_missing unzip unzip
      install_missing curl curl
      install_missing wget wget
      install_missing git_lfs git-lfs
      install_missing make make
      install_missing cc build-base
      ;;
    brew)
      install_missing git git
      install_missing rg ripgrep
      install_missing fd fd
      install_missing lazygit lazygit
      install_missing node node
      install_missing python3 python3
      install_missing unzip unzip
      install_missing curl curl
      install_missing wget wget
      install_missing git_lfs git-lfs
      install_missing make make
      install_missing cc gcc
      install_missing docker docker
      ;;
  esac

  log "Done. Re-run :checkhealth deps inside Neovim to verify."
}

main "$@"