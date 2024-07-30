autocmd("LspAttach", {
	callback = function(args)
		local opts = { noremap = true, silent = true, buffer = args.buf }
		map("n", "gi", "<cmd>Trouble lsp_implementations toggle focus=true<cr>", opts)
		map("n", "gr", "<cmd>Trouble lsp_references toggle focus=true<cr>", opts)
		map("n", "gtd", "<cmd>Trouble lsp_type_definitions toggle focus=true<cr>", opts)
		map("n", "cd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostic" })
		map(
			"n",
			"\\i",
			"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
			{ desc = "toggle inlay_hints" }
		)
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "code_action" })
		map("n", "<leader>cs", "<cmd>Trouble lsp toggle<cr>", { desc = "symbols" })
		map("n", "<leader>cr", ":Rename ", { silent = true, desc = "rename" })
		map("n", "gd", ":lua vim.lsp.buf.definition()<cr>", opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		-- map("n", "<leader>k", vim.lsp.buf.signature_help, opts)
		map("n", "<leader>k", vim.lsp.buf.hover, opts)
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
	signs = true,
	virtual_text = false,
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

-- lsp-gutterSigns --
local signs = { Error = "", Warn = "󰔶", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	---@diagnostic disable-next-line: redefined-local
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
