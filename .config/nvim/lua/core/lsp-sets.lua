Autocmd("LspAttach", {
	callback = function(args)
		local opts = { noremap = true, silent = true, buffer = args.buf }
		Map("n", "gi", vim.lsp.buf.implementation, opts)
		Map("n", "gd", vim.lsp.buf.definition, opts)
		Map("n", "gr", vim.lsp.buf.references, opts)
		Map("n", "gtd", vim.lsp.buf.type_definition, opts)
		Map("n", "gD", vim.lsp.buf.declaration, opts)
		Map("n", "gk", vim.lsp.buf.hover, opts)
		Map("n", "<leader>k", vim.lsp.buf.signature_help, { silent = true, desc = "sig_help" })
		Map("n", "<leader>cr", vim.lsp.buf.rename, { silent = true, desc = "rename" })
		Map("n", "<leader>cd", vim.diagnostic.setqflist, { silent = true, desc = "diag" })
		Map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "code_action" })
		Map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		Map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		Map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		Map({ "n", "i" }, "<C-s>", vim.lsp.buf.format, opts)
	end,
})
-- diagnostic config --
vim.diagnostic.config({
	signs = true,
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})
-- lsp-gutterSigns --
local signs = { Error = "", Warn = "󰔶", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	---@diagnostic disable-next-line: redefined-local
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
