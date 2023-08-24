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
    require("bufferline").setup({})
  end,
}
