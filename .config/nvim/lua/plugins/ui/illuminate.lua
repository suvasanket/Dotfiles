return {
	"RRethy/vim-illuminate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
				"treesitter",
			},
			iletypes_denylist = {
				"TelescopePrompt",
				"TelescopeResults",
			},
			min_count_to_highlight = 2,
			delay = 100,
		})
	end,
}
