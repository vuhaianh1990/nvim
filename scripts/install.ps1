#Requires -RunAsAdministrator
<#
.SYNOPSIS
  Installs dependencies required to run this Neovim (LazyVim) config on Windows.
.DESCRIPTION
  Uses winget. Installs only what is missing. Neovim itself is included.
#>

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

Write-Host ""
Write-Host "[install] Done." -ForegroundColor Green
Write-Host "A new terminal may be required to refresh PATH. Then run :checkhealth deps in Neovim." -ForegroundColor Yellow