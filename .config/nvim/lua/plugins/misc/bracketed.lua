return {
	"echasnovski/mini.bracketed",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("mini.bracketed").setup({
			treesitter = { suffix = '', options = {} },
		})
	end,
}
