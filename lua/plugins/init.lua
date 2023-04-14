return {
  "folke/which-key.nvim",
  "folke/neodev.nvim",
  -- Theme colorscheme
  "EdenEast/nightfox.nvim",
  "marko-cerovac/material.nvim",
  { "catppuccin/nvim", name = "catppuccin" },
  -- useins
  "nvim-lualine/lualine.nvim", -- Statusline
  "nvim-lua/plenary.nvim",     -- Common utilities
  "onsails/lspkind-nvim",      -- vscode-like pictograms
  "MunifTanjim/prettier.nvim", -- Prettier plugin for Neovim's built-in LSP client
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  -- For luasnip users.
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- For ultisnips users.
  "SirVer/ultisnips",
  "quangnguyen30192/cmp-nvim-ultisnips",

  -- For snippy users.
  "dcampos/nvim-snippy",
  "dcampos/cmp-snippy",

  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-file-browser.nvim" },
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "norcalli/nvim-colorizer.lua",
  "folke/zen-mode.nvim",

  -- GIT
  "kdheepak/lazygit.nvim",
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",

  -- Custom plugins
  "petertriho/nvim-scrollbar",
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  "dart-lang/dart-vim-plugin",
  "natebosch/vim-lsc",      -- dart flutter
  "natebosch/vim-lsc-dart", -- dart flutter
  {
    "nvim-tree/nvim-tree.lua",
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  },
  { "fgheng/winbar.nvim" },
  "echasnovski/mini.nvim",

  -- Find and replace
  "nvim-pack/nvim-spectre",
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },

  -- Sad replace files
  {
    "ray-x/sad.nvim",
    dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
    config = function()
      require("sad").setup({})
    end,
  },
  "nvim-pack/nvim-spectre",

  -- File Explore
  "kevinhwang91/rnvimr",
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
}
