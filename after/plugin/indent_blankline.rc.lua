vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent7 guifg=#564E4E gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent8 guibg=#1f1f1f gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent9 guibg=#1a1a1a gui=nocombine]])

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup({
	char = "",
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	show_trailing_blankline_indent = false,
	space_char_highlight_list = {
		"IndentBlanklineIndent8",
		"IndentBlanklineIndent9",
	},
	char_highlight_list = {
		"IndentBlanklineIndent8",
		"IndentBlanklineIndent9",
	},
})
