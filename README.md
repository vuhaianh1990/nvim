# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Dependencies

This config needs a few tools on your system besides Neovim itself:

| Tool                              | Required | Used for                          |
| --------------------------------- | -------- | --------------------------------- |
| Neovim ≥ 0.11                     | ✅       | editor                            |
| `git`                             | ✅       | plugin management (lazy.nvim)     |
| `rg` (ripgrep)                    | ✅       | live grep / file search           |
| `fd`                              | ✅       | fuzzy file finding (fallback)     |
| `lazygit`                         | ✅       | git integration (gitsigns, snacks) |
| `node` ≥ 18 + `npm`               | ✅       | LSP servers, copilot, prettier, eslint |
| `python3`                         | ✅       | python tooling / LSP helpers      |
| `unzip`, `curl`                   | ✅       | plugin & tool installs            |
| `wget`, `git-lfs`, `gcc`, `make`, `docker` | ⬜ | optional extras              |

## Quick install

Run `:checkhealth deps` (or `:checkhealth`) inside Neovim to see what's missing and the exact install command.

Install everything automatically in one shot:

**Linux / macOS:**

```bash
~/.config/nvim/scripts/install.sh        # installs missing tools with sudo
~/.config/nvim/scripts/install.sh --dry-run   # preview first, make no changes
```

**Windows (PowerShell, winget, admin required):**

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.config\nvim\scripts\install.ps1"
```

**From inside Neovim:** `<leader>di` or `:InstallDeps`.

## Verify

```vim
:checkhealth deps
```