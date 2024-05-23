return {
	{
		"echasnovski/mini.starter",
		enabled = false,
		event = "VimEnter",
		config = function()
			local starter = require("mini.starter")
			starter.setup({
				silent = true,
				footer = "Hello World!!",
				content_hooks = {
					starter.gen_hook.adding_bullet("█ ", nil),
					starter.gen_hook.aligning("center", "center"),
				},
			})
		end,
	},
}
