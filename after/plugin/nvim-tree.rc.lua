-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "all",
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  }
})

-- Mapping
local keymap = vim.keymap
keymap.set('n', '<space>e', ':NvimTreeToggle<Cr>')
