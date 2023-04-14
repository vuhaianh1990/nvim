return {
	"glepnir/lspsaga.nvim",
	lazy = true,
	branch = "main",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			server_filetype_map = {
				typescript = "typescript",
			},
			symbol_in_winbar = {
				enable = true,
				separator = " ",
				hide_keyword = true,
				show_file = true,
				folder_level = 2,
				respect_root = false,
			},
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		--Please make sure you install markdown and markdown_inline parser
		{ "nvim-treesitter/nvim-treesitter" },
	},
	keys = {

		-- LSP finder - Find the symbol's definition
		-- If there is no definition, it will instead be hidden
		-- When you use an action in finder like "open vsplit",
		-- you can use <C-t> to jump back
		{ "gh", "<cmd>Lspsaga lsp_finder<cr>" },

		-- Code action
		{
			"<leader>ca",
			"<cmd>Lspsaga code_action<cr>",
			mode = { "n", "v" },
		},
		-- Rename all occurrences of the hovered word for the entire file

		{ "gr", "<cmd>Lspsaga rename<cr>" },
		-- Rename all occurrences of the hovered word for the selected files
		{ "gr", "<cmd>Lspsaga rename ++project<cr>" },
		-- Peek definition
		-- You can edit the file containing the definition in the floating windo},
		-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
		-- It also supports tagstack
		-- Use <C-t> to jump bac},
		{ "gp", "<cmd>Lspsaga peek_definition<cr>" },
		-- Go to definitio},
		{ "gd", "<cmd>Lspsaga goto_definition<cr>" },
		-- Peek type definition
		-- You can edit the file containing the type definition in the floating windo},
		-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys},
		-- It also supports tagstack
		-- Use <C-t> to jump bac},
		{ "gx", "<cmd>Lspsaga peek_type_definition<cr>" },
		-- Go to type definitio},
		{ "gt", "<cmd>Lspsaga goto_type_definition<cr>" },
		-- Show line diagnostics
		-- You can pass argument ++unfocus to
		-- unfocus the show_line_diagnostics floating windo},
		{ "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<cr>" },
		-- Show buffer diagnostics
		{ "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<cr>" },
		-- Show workspace diagnostics
		{ "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<cr>" },
		-- Show cursor diagnostics
		{ "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<cr>" },
		-- Diagnostic jump
		-- You can use <C-o> to jump back to your previous location
		{ "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
		{ "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>" },
		-- Diagnostic jump with filters such as only jumping to an error
		{
			"[E",
			function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end,
		},
		{
			"]E",
			function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end,
		},
		-- Toggle outline
		{ "<leader>o", "<cmd>Lspsaga outline<cr>" },
		-- Hover Doc
		-- If there is no hover doc,
		-- there will be a notification stating that
		-- there is no information available.
		-- To disable it just use ":Lspsaga hover_doc ++quiet"
		-- Pressing the key twice will enter the hover window
		{ "K", "<cmd>Lspsaga hover_doc<cr>" },
		-- If you want to keep the hover window in the top right hand corner,
		-- you can pass the ++keep argument
		-- Note that if you use hover with ++keep, pressing this key again will
		-- close the hover window. If you want to jump to the hover window
		-- you should use the wincmd command "<C-w>w"
		{ "K", "<cmd>Lspsaga hover_doc ++keep<cr>" },
		-- Call hierarchy
		{ "<Leader>ci", "<cmd>Lspsaga incoming_calls<cr>" },
		{ "<Leader>co", "<cmd>Lspsaga outgoing_calls<cr>" },
		-- Floating terminal
		{ "<A-d>", "<cmd>Lspsaga term_toggle<cr>", mode = "t" },
	},
}
