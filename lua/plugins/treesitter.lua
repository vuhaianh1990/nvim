return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
	init = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = true,
				disable = {},
			},
			ensure_installed = {
				"tsx",
				"toml",
				"fish",
				"php",
				"json",
				"yaml",
				"swift",
				"css",
				"html",
				"lua",
				"dart",
				"markdown",
				"markdown_inline",
			},
			autotag = {
				enable = true,
			},
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
	end,
}
