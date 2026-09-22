-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Install missing Neovim dependencies (run scripts/install.sh on Linux/macOS, install.ps1 on Windows)
vim.api.nvim_create_user_command("InstallDeps", function()
  require("deps.health").install()
end, { desc = "Install missing Neovim dependencies" })
keymap.set("n", "<leader>di", ":InstallDeps<CR>", { desc = "Install Neovim dependencies" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "te", ":tabnew<Return>", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
