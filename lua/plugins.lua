local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Theme colorscheme
  use {'nyoom-engineering/oxocarbon.nvim'}
  use "EdenEast/nightfox.nvim"

  -- useins
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}


  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
          require('lspsaga').setup({})
      end,
  })

  -- For luasnip users.
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- For ultisnips users.
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- For snippy users.
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim'
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/zen-mode.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- GIT
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'

  -- Custom plugins
  use "petertriho/nvim-scrollbar"
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'dart-lang/dart-vim-plugin'
  use 'natebosch/vim-lsc' -- dart flutter
  use 'natebosch/vim-lsc-dart' -- dart flutter
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use { 'fgheng/winbar.nvim' }
  use { 'echasnovski/mini.nvim', branch = 'stable' }

  -- Find and replace
  use 'windwp/nvim-spectre'
  use {
    'mg979/vim-visual-multi',
    branch = 'master'
  }

  -- NX Workspace
  use {
    'Equilibris/nx.nvim',
    requires = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require("nx").setup {}
    end
  }

end)
