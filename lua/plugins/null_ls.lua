return {
	"jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	config = function()
		local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
    local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.completion.spell,
				-- null_ls.builtins.diagnostics.eslint_d.with({
				--   diagnostics_format = '[eslint] #{m}\n(#{c})'
				-- }),
				null_ls.builtins.diagnostics.fish,
			},
			on_attach = function(client, bufnr)
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup_format,
						buffer = 0,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end,
		})
	end,
}
