return {
	"akinsho/bufferline.nvim",
	version = "v3.*",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<Tab>", "<cmd>BufferLineCycleNext<cr>" },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>" },
	},
	init = function()
		require("bufferline").setup({
			options = {
				mode = "tabs",
				separator_style = "thin",
				show_close_icon = true,
				color_icons = true,
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				indicator = {
					icon = "▎", -- this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = ""
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " "
							or (e == "warning" and " " or " ")
							or (e == "info" and "")
						s = s .. n .. sym
					end
					return s
				end,
			},
			highlights = {
				separator = {
					fg = "#073642",
					bg = "#002b36",
				},
				separator_selected = {
					fg = "#073642",
				},
				background = {
					fg = "#657b83",
					bg = "#002b36",
				},
				buffer_selected = {
					fg = "#fdf6e3",
					bold = true,
				},
				fill = {
					bg = "#073642",
				},
			},
		})
	end,
}
