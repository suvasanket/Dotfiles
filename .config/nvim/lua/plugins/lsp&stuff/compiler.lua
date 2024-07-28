require("core.helper")

return {
	{
		"ej-shafran/compile-mode.nvim",
		branch = "latest",
		cmd = { "Compile", "Recompile" },
		keys = {
			{ "<leader>cc", ":Compile ", desc = "Compile" },
			{ "<leader>cr", cmd("Recompile"), desc = "Recompile" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		opts = {
			default_command = "node",
			error_regexp_table = {
				javascript = {
					regex = "at [^ ]+ (\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\)",
					filename = 1,
					row = 2,
					col = 3,
				},
			},
		},
	},
}
