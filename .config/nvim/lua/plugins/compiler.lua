require("core.helper")

return {
	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>cc", "<cmd>OverseerRunCmd<cr>", desc = "run cmd" },
			{ "<leader>ct", "<cmd>OverseerToggle<cr>", desc = "overseer" },
		},
		opts = {
			dap = false,
			task_list = {
				bindings = {
					["<C-k>"] = false,
					["<C-j>"] = false,
					["<C-l>"] = false,
					["<C-h>"] = false,
					["<C-u>"] = "ScrollOutputUp",
					["<C-d>"] = "ScrollOutputDown",
					["<C-q>"] = "q<cmd>OverseerQuickAction open output in quickfix<cr>",
					["r"] = "<cmd>OverseerQuickAction restart<cr><esc>",
					["x"] = "<cmd>OverseerQuickAction dispose<cr>",
					["w"] = "<cmd>OverseerQuickAction watch<cr>",
				},
			},
		},
	},
}
