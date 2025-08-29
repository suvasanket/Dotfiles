Autocmd("LspAttach", {
	callback = function(args)
		local opts = { noremap = true, silent = true, buffer = args.buf }
		Map("n", "gd", vim.lsp.buf.definition, opts)
		Map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
		Map("n", "<leader>wd", vim.lsp.buf.workspace_diagnostics, opts)
		Map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
})

vim.diagnostic.config({
	virtual_text = true,
})

----------- ** server specific configs ** -----------

vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
}

vim.lsp.config["tsserver"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "typescript" },
	root_markers = { ".git", "package.json" },
}

vim.lsp.enable({ "luals", "tsserver" })
