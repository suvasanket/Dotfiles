return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "x" }, desc = "comment" },
		{ "gb", mode = { "n", "x" }, desc = "comment" },
	},
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},
	opts = {
		pre_hook = function()
			require("ts_context_commentstring.internal").update_commentstring({})
		end,
	},
	config = function(_, opts)
		require("Comment").setup(opts)
	end,
}
