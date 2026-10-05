#Requires -Version 5.1
<#
.SYNOPSIS
  Installs dependencies required to run this Neovim (LazyVim) config on Windows.
.DESCRIPTION
  Uses winget. Installs only what is missing, then installs the Neovim plugins
  headlessly (Lazy sync). Neovim itself is included.
  Run from an elevated ("Run as administrator") PowerShell if installers
  require elevation; otherwise Windows will ask via UAC.
.PARAMETER NoPlugins
  Only install system dependencies; skip the headless Neovim plugin sync.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -NoPlugins
#>
param(
  [switch]$NoPlugins
)

$ErrorActionPreference = "Stop"

function Test-Command {
  param([string]$Name)
  return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

function Install-WingetPkg {
  param([string]$Id)
  if (winget list --id $Id --accept-source-agreements --disable-interactivity *> $null) {
    Write-Host "[install] $Id already installed. Skipping." -ForegroundColor Cyan
  } else {
    Write-Host "[install] > winget install --silent --accept-package-agreements $Id" -ForegroundColor Cyan
    winget install --id $Id --silent --accept-package-agreements --accept-source-agreements --disable-interactivity
  }
}

# winget updates the PATH in the registry, but the current process keeps the
# old copy. Re-read it so freshly installed tools (nvim, git) are usable below.
function Refresh-Path {
  $machinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
  $userPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
  $env:Path = (@($machinePath, $userPath) | Where-Object { $_ }) -join ";"
}

# Bootstrap lazy.nvim and install/update every plugin, headless.
function Install-NvimPlugins {
  if (-not (Test-Command nvim)) {
    Write-Host "[install] nvim not found on PATH; skipping Neovim plugin installation." -ForegroundColor Yellow
    Write-Host "[install] Open a new terminal, re-run this script, or run :Lazy sync inside Neovim." -ForegroundColor Yellow
    return
  }

  Write-Host "[install] Installing Neovim plugins (headless Lazy sync)..." -ForegroundColor Cyan
  & nvim --headless "+Lazy! sync" +qa
  if ($LASTEXITCODE -eq 0) {
    Write-Host "[install] Neovim plugins installed." -ForegroundColor Green
  } else {
    Write-Host "[install] Plugin sync failed (exit $LASTEXITCODE). Open Neovim and run :Lazy sync." -ForegroundColor Yellow
  }
}

if (-not (Test-Command winget)) {
  throw "winget is not available. Install it: https://apps.microsoft.com/detail/9nblggh4nns1"
}

Write-Host "[install] Windows detected, using winget." -ForegroundColor Cyan
Write-Host "[install] Installing Neovim >= 0.11 + required dependencies..." -ForegroundColor Cyan

# Core / required
Install-WingetPkg "Neovim.Neovim"
Install-WingetPkg "Git.Git"
Install-WingetPkg "BurntSushi.ripgrep.MSVC"
Install-WingetPkg "sharkdp.fd"
Install-WingetPkg "JesseDuffield.lazygit"
Install-WingetPkg "OpenJS.NodeJS.LTS"
Install-WingetPkg "Python.Python.3"

# Optional but recommended (native-node modules, ripgrep/fd need it on older builds)
Install-WingetPkg "Microsoft.VCRedist.2015+.x64"

# Make tools just installed by winget visible to this process before syncing plugins.
Refresh-Path

if ($NoPlugins) {
  Write-Host "[install] Skipping Neovim plugin installation (-NoPlugins)." -ForegroundColor Cyan
} else {
  Install-NvimPlugins
}

Write-Host ""
Write-Host "[install] Done." -ForegroundColor Green
Write-Host "A new terminal may be required to refresh PATH. Then run :checkhealth deps in Neovim." -ForegroundColor Yellow
