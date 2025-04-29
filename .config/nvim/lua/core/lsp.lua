Autocmd("LspAttach", {
	callback = function(args)
		local opts = { noremap = true, silent = true, buffer = args.buf }
		Map("n", "gd", vim.lsp.buf.definition, opts)
		Map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
})

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

-- snippet
vim.keymap.set({ "i", "s" }, "<C-f>", function()
	if vim.snippet.active({ direction = 1 }) then
		vim.cmd([[lua vim.snippet.jump(1)]])
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-b>", function()
	if vim.snippet.active({ direction = 1 }) then
		vim.cmd([[lua vim.snippet.jump(-1)]])
	end
end, { silent = true })
