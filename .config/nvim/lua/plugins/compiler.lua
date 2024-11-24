require("core.helper")

return {
	{
		"ej-shafran/compile-mode.nvim",
		branch = "latest",
		cmd = "Compile",
		dependencies = {
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.g.compile_mode = {
				baleia_setup = true,
			}
		end,
	},
}
-- return {
-- 	{
-- 		"stevearc/overseer.nvim",
-- 		keys = {
-- 			{ "<leader>cc", "<cmd>OverseerRunCmd<cr>", desc = "run cmd" },
-- 			{ "<leader>ct", "<cmd>OverseerToggle<cr>", desc = "overseer" },
-- 		},
-- 		opts = {
-- 			dap = false,
-- 			task_list = {
-- 				bindings = {
-- 					["<C-k>"] = false,
-- 					["<C-j>"] = false,
-- 					["<C-l>"] = false,
-- 					["<C-h>"] = false,
-- 					["<C-u>"] = "ScrollOutputUp",
-- 					["<C-d>"] = "ScrollOutputDown",
-- 					["<C-q>"] = "q<cmd>OverseerQuickAction open output in quickfix<cr>",
-- 					["r"] = "<cmd>OverseerQuickAction restart<cr><esc>",
-- 					["x"] = "<cmd>OverseerQuickAction dispose<cr>",
-- 					["w"] = "<cmd>OverseerQuickAction watch<cr>",
-- 				},
-- 			},
-- 		},
-- 	},
-- }
