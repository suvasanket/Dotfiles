require("core.helper")

return {
	{
		"ej-shafran/compile-mode.nvim",
		branch = "nightly",
		cmd = { "Compile", "Recompile" },
		dependencies = {
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.g.compile_mode = {
				baleia_setup = true,
				use_diagnostics = false,
				auto_jump_to_first_error = false,
			}
		end,
	},
}
