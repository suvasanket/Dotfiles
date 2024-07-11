return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		{ "ThePrimeagen/refactoring.nvim" },
		{ "jay-babu/mason-null-ls.nvim" },
	},
	event = { "LspAttach", "BufReadPost" },
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {},
		})
		require("null-ls").setup({
			sources = {},
		})
	end,
}
