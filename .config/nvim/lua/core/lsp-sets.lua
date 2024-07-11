--{{{ helper
-- vim: foldmethod=marker
-- vim: foldlevel=0
local lsp = require("lspconfig")
local root_pattern = lsp.util.root_pattern

--capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

--lsp-virtualText_prefix--
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

--lsp-gutterSigns--
local signs = { Error = "", Warn = "󰔶", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	---@diagnostic disable-next-line: redefined-local
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

--lsp on_attach
local on_attach = function(client, bufnr)
	--inlay hint
	-- if client.server_capabilities.inlayHintProvider then
	-- 	vim.lsp.inlay_hint.enable(false)
	-- end
end

--lsp default_config
lsp.util.default_config = vim.tbl_extend("force", lsp.util.default_config, {
	capabilities = capabilities,
	on_attach = on_attach,
})

--}}}

--ruby
lsp.solargraph.setup({})
-- lsp.rubocop.setup({})

--c/c++
capabilities.offsetEncoding = { "utf-16" }
lsp.clangd.setup({
	capabilities = capabilities,
})

--keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { noremap = true, silent = true, buffer = args.buf }
		vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations toggle focus=true<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references toggle focus=true<cr>", opts)
		vim.keymap.set("n", "gtd", "<cmd>Trouble lsp_type_definitions toggle focus=true<cr>", opts)
		vim.keymap.set("n", "cd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostic" })
		vim.keymap.set(
			"n",
			"\\i",
			"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
			{ desc = "toggle inlay_hints" }
		)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "code_action" })
		vim.keymap.set("n", "<leader>cs", "<cmd>Trouble lsp toggle<cr>", { desc = "symbols" })
		vim.keymap.set("n", "<F2>", ":Rename ", { silent = true, desc = "rename" })
		vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		-- vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.format, opts)
	end,
})
