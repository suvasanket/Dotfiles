return {
	"echasnovski/mini.move",
	keys = {
		{ "H", mode = { "x", "n" } },
		{ "J", mode = { "x", "n" } },
		{ "K", mode = { "x", "n" } },
		{ "L", mode = { "x", "n" } },
	},
	config = function()
		require("mini.move").setup({
			mappings = {
				-- Cove visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "H",
				right = "L",
				down = "J",
				up = "K",

				-- Cove current line in Normal mode
				line_left = "H",
				line_right = "L",
				line_down = "J",
				line_up = "K",
			},

			-- Options which control moving behavior
			options = {
				reindent_linewise = true,
			},
		})
	end,
}
