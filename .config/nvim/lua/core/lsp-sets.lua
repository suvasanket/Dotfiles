autocmd("LspAttach", {
	callback = function(args)
		local opts = { noremap = true, silent = true, buffer = args.buf }
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "gtd", vim.lsp.buf.type_definition, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gk", vim.lsp.buf.hover, opts)
		map("n", "<leader>k", vim.lsp.buf.signature_help, opts)
		map("n", "<leader>cr", vim.lsp.buf.rename, { silent = true, desc = "rename" })
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "code_action" })
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		map({ "n", "i" }, "<C-s>", vim.lsp.buf.format, opts)
	end,
})
-- diagnostic config --
vim.diagnostic.config({
	signs = false,
	virtual_text = true,
	update_in_insert = false,
	underline = false,
	severity_sort = true,
	float = {
		border = "rounded",
		severity_sort = true,
		header = {},
		suffix = function(diag)
			local message
			if diag.code then
				message = ("%s (%s)"):format(diag.source, diag.code)
			else
				message = diag.source
			end
			return " " .. message, "DiagnosticFloatingSuffix"
		end,
		prefix = function(diagnostic)
			if diagnostic.severity == vim.diagnostic.severity.ERROR then
				return "" -- Nerd font icon for error
			elseif diagnostic.severity == vim.diagnostic.severity.WARN then
				return "" -- Nerd font icon for warning
			elseif diagnostic.severity == vim.diagnostic.severity.INFO then
				return "" -- Nerd font icon for info
			else
				return "" -- Nerd font icon for hint
			end
		end,
		format = function(diag)
			return diag.message
		end,
	},
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
