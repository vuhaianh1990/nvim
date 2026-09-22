local M = {}

local H = vim.health

local OS = vim.loop.os_uname().sysname
local IS_WINDOWS = vim.fn.has("win32") == 1
local IS_MAC = OS == "Darwin"
local IS_LINUX = OS == "Linux"

local distro = ""
if IS_LINUX then
  for _, line in ipairs(vim.fn.systemlist("cat /etc/os-release 2>/dev/null || true")) do
    local id = line:match("^ID=(.-)$") or line:match('^ID="(.-)"$')
    if id then
      distro = id:lower()
      break
    end
  end
end

local DISTRO_CMD = {
  arch = "sudo pacman -S --needed --noconfirm %s",
  manjaro = "sudo pacman -S --needed --noconfirm %s",
  debian = "sudo apt install -y %s",
  ubuntu = "sudo apt install -y %s",
  fedora = "sudo dnf install -y %s",
  rhel = "sudo dnf install -y %s",
  centos = "sudo dnf install -y %s",
  opensuse = "sudo zypper install -y %s",
  suse = "sudo zypper install -y %s",
  alpine = "sudo apk add %s",
}

local DISTRO_PKGS = {
  nvim = { arch = "neovim", fedora = "neovim", ubuntu = "neovim", opensuse = "neovim", alpine = "neovim", mac = "neovim", win = "Neovim.Neovim" },
  git = { arch = "git", fedora = "git", ubuntu = "git-core", opensuse = "git-core", alpine = "git", mac = "git", win = "Git.Git" },
  rg = { arch = "ripgrep", fedora = "ripgrep", ubuntu = "ripgrep", opensuse = "ripgrep", alpine = "ripgrep", mac = "ripgrep", win = "BurntSushi.ripgrep.MSVC" },
  fd = { arch = "fd", fedora = "fd-find", ubuntu = "fd-find", opensuse = "fd", alpine = "fd", mac = "fd", win = "sharkdp.fd" },
  lazygit = { arch = "lazygit", fedora = "lazygit", ubuntu = "lazygit", opensuse = "lazygit", alpine = "lazygit", mac = "lazygit", win = "JesseDuffield.lazygit" },
  node = { arch = "nodejs npm", fedora = "nodejs npm", ubuntu = "nodejs npm", opensuse = "nodejs npm", alpine = "nodejs npm", mac = "node", win = "OpenJS.NodeJS.LTS" },
  python3 = { arch = "python python-pip", fedora = "python3 python3-pip", ubuntu = "python3 python3-pip", opensuse = "python3 python3-pip", alpine = "python3 py3-pip", mac = "python3", win = "Python.Python.3" },
  unzip = { arch = "unzip", fedora = "unzip", ubuntu = "unzip", opensuse = "unzip", alpine = "unzip", mac = "unzip", win = nil },
  curl = { arch = "curl", fedora = "curl", ubuntu = "curl", opensuse = "curl", alpine = "curl", mac = "curl", win = nil },
  wget = { arch = "wget", fedora = "wget", ubuntu = "wget", opensuse = "wget", alpine = "wget", mac = "wget", win = nil },
  docker = { arch = "docker", fedora = "docker", ubuntu = "docker.io", opensuse = "docker", alpine = "docker", mac = nil, win = nil },
  git_lfs = { arch = "git-lfs", fedora = "git-lfs", ubuntu = "git-lfs", opensuse = "git-lfs", alpine = "git-lfs", mac = "git-lfs", win = nil },
  pip3 = { arch = "python-pip", fedora = "python3-pip", ubuntu = "python3-pip", opensuse = "python3-pip", alpine = "py3-pip", mac = "python3", win = nil },
  gcc = { arch = "gcc", fedora = "gcc", ubuntu = "build-essential", opensuse = "gcc", alpine = "build-base", mac = "gcc", win = nil },
  make = { arch = "make", fedora = "make", ubuntu = "make", opensuse = "make", alpine = "make", mac = "make", win = nil },
}

local REQUIRED = {
  nvim = { hint = "neovim", version = true },
  git = { hint = "git", version = true },
  rg = { hint = "ripgrep", aliases = { "ripgrep" } },
  fd = { hint = "fd", aliases = { "fdfind" } },
  lazygit = { hint = "lazygit" },
  node = { hint = "nodejs + npm", version = true },
  python3 = { hint = "python3", aliases = { "python" } },
  unzip = { hint = "unzip" },
  curl = { hint = "curl" },
}

local OPTIONAL = {
  pip3 = { hint = "pip3 / uv", aliases = { "uv" } },
  wget = { hint = "wget" },
  docker = { hint = "docker" },
  git_lfs = { hint = "git-lfs", aliases = { "git-lfs" } },
  gcc = { hint = "gcc/build tools", aliases = { "cc" } },
  make = { hint = "make" },
}

local function node_version()
  local out = vim.fn.systemlist("node --version")
  local version = (out and out[1] or ""):gsub("^v", "")
  local major = tonumber(version:match("^(%d+)"))
  if major and major >= 18 then
    return "Node.js v" .. version
  end
  return "Node.js v" .. version .. " (LazyVim recommends >= 18)"
end

local function cmd_version(cmd)
  local out = vim.fn.systemlist(cmd .. " --version")
  return out and out[1] or ""
end

local function find_cmd(tool)
  if vim.fn.executable(tool) == 1 then
    return tool
  end
  local spec = REQUIRED[tool] or OPTIONAL[tool]
  for _, alias in ipairs(spec.aliases or {}) do
    if vim.fn.executable(alias) == 1 then
      return alias
    end
  end
  return nil
end

local function install_cmd(tool)
  local pkg = DISTRO_PKGS[tool]
  if IS_MAC then
    return pkg.mac and string.format("brew install %s", pkg.mac) or nil
  elseif IS_WINDOWS then
    return pkg.win and string.format("winget install --silent %s", pkg.win) or nil
  end
  local cmd = DISTRO_CMD[distro]
  return cmd and pkg[distro] and string.format(cmd, pkg[distro]) or nil
end

local function check_tool(tool, spec, is_required)
  local bin = find_cmd(tool)
  if bin then
    local detail = bin
    if spec.version then
      if tool == "node" then
        detail = node_version()
      else
        detail = cmd_version(bin)
      end
    end
    detail = vim.trim(detail)
    if detail == "" then
      detail = bin
    end
    H.ok(string.format("%s: found (%s)", spec.hint, detail))
  else
    local msg = string.format("%s: not found", spec.hint)
    local cmd = install_cmd(tool)
    if cmd then
      msg = msg .. "\nInstall with: " .. cmd
    end
    if is_required then
      H.error(msg)
    else
      H.warn(msg)
    end
  end
end

local function check_nvim()
  if vim.version().minor >= 11 then
    H.ok(string.format("Neovim %d.%d.%d", vim.version().major, vim.version().minor, vim.version().patch))
  else
    H.warn(
      string.format(
        "Neovim %d.%d.%d: LazyVim recommends >= 0.11\nInstall with: %s",
        vim.version().major,
        vim.version().minor,
        vim.version().patch,
        install_cmd("nvim")
      )
    )
  end
end

function M.check()
  H.start("nvim-deps")

  if IS_LINUX then
    H.info("Platform: Linux" .. (distro ~= "" and " (" .. distro .. ")" or ""))
  elseif IS_MAC then
    H.info("Platform: macOS")
  elseif IS_WINDOWS then
    H.info("Platform: Windows")
  else
    H.info("Platform: unknown (" .. OS .. ")")
  end

  H.info("Required dependencies:")
  for tool, spec in pairs(REQUIRED) do
    check_tool(tool, spec, true)
  end

  H.info("Optional dependencies:")
  for tool, spec in pairs(OPTIONAL) do
    check_tool(tool, spec, false)
  end
end

function M.install()
  local config = vim.fn.stdpath("config")
  local cmd
  if IS_WINDOWS then
    cmd = config .. "/scripts/install.ps1"
  else
    cmd = config .. "/scripts/install.sh"
  end

  if vim.fn.filereadable(cmd) ~= 1 then
    H.error(string.format("Installer script not found: %s", cmd))
    return
  end

  local choice = vim.fn.confirm(
    "This will install missing Neovim dependencies using your system package manager. Continue?",
    "&Yes\n&No",
    1
  )
  if choice ~= 1 then
    return
  end

  local out
  if IS_WINDOWS then
    out = vim.fn.system({ "powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", cmd })
  else
    out = vim.fn.system({ "bash", cmd })
  end

  vim.api.nvim_echo({ { out or "", "Normal" } }, true, {})
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Dependency install failed. See output above.", "ErrorMsg" } }, true, {})
  else
    vim.api.nvim_echo({ { "Dependencies installed. Re-run :checkhealth deps to verify.", "MoreMsg" } }, true, {})
  end
end

return M