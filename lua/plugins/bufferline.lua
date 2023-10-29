return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<Tab>",   "<cmd>BufferLineCycleNext<cr>" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>" },
  },
  init = function()
    vim.opt.termguicolors = true
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },

        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "underline",
        },
      },
    })
  end,
}
