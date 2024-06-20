return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		{ "semanticart/ruby-code-actions.nvim" },
		{ "ThePrimeagen/refactoring.nvim" },
	},
	event = { "LspAttach" },
	config = function()
		local null_ls = require("null-ls")
		local builtins = require("null-ls").builtins
		local format = builtins.formatting
		local diagnostics = builtins.diagnostics
		local codeaction = builtins.code_actions
		local ruby_code_actions = require("ruby-code-actions")

		null_ls.setup({
			sources = {
				format.black,
				format.stylua,
				format.clang_format,
				format.shfmt,
				format.rubocop,

				ruby_code_actions.insert_frozen_string_literal,
				ruby_code_actions.autocorrect_with_rubocop,

				diagnostics.zsh,
				-- diagnostics.rubocop,

				codeaction.refactoring,
				codeaction.gitrebase,
			},
		})
	end,
}
