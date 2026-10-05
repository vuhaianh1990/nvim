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

Install everything automatically in one shot. The scripts install the system
tools first, then bootstrap `lazy.nvim` and sync every plugin headlessly via
`nvim --headless "+Lazy! sync" +qa` (so macOS, Linux, and Windows all end up
with the plugins installed).

**Linux / macOS:**

```bash
~/.config/nvim/scripts/install.sh              # installs missing tools with sudo + plugins
~/.config/nvim/scripts/install.sh --dry-run    # preview first, make no changes
~/.config/nvim/scripts/install.sh --no-plugins # system tools only, skip plugin sync
```

**Windows (PowerShell, winget, admin required):**

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.config\nvim\scripts\install.ps1"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.config\nvim\scripts\install.ps1" -NoPlugins
```

**From inside Neovim:** `<leader>di` or `:InstallDeps`. This opens a
`:terminal` window and runs the installer there, so `sudo` can prompt for
your password (you can still watch the progress and close the window when
done).

> Neovim plugins live in a shared data directory (`stdpath("data")`), so if you
> already synced on this machine the plugin step is quick and just updates.

## Verify

```vim
:checkhealth deps
```