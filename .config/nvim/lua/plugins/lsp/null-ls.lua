return {
	"nvimtools/none-ls.nvim",
	event = { "LspAttach" },
	config = function()
		local null_ls = require("null-ls")
		local builtins = require("null-ls").builtins
		local format = builtins.formatting
		local diagnostics = builtins.diagnostics
		local codeaction = builtins.code_actions

		null_ls.setup({
			sources = {
				format.black,
				format.stylua,
				format.clang_format,
				format.shfmt,

				diagnostics.zsh,

				codeaction.refactoring,
				codeaction.gitrebase,
			},
		})
	end,
	dependencies = {
		"ThePrimeagen/refactoring.nvim",
	},
}
