return {
	"echasnovski/mini.move",
	keys = {
		{ "<C-h>", mode = "x" },
		{ "<C-j>", mode = "x" },
		{ "<C-k>", mode = "x" },
		{ "<C-l>", mode = "x" },
	},
	config = function()
		require("mini.move").setup({
			mappings = {
				-- Cove visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<C-h>",
				right = "<C-l>",
				down = "<C-j>",
				up = "<C-k>",

				-- Cove current line in Normal mode
				line_left = "",
				line_right = "",
				line_down = "",
				line_up = "",
			},

			-- Options which control moving behavior
			options = {
				reindent_linewise = true,
			},
		})
	end,
}
