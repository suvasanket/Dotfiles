require("core.helper")

return {
	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>xx", cmd("OverseerToggle<cr>"), desc = "OverseerToggle" },
			{ "<leader>xr", cmd("OverseerRun<cr>"), desc = "run" },
			{ "<leader>xc", cmd("MakeC"), desc = "Make cur" },
		},
		cmd = {
			"Make",
			"Run",
			"OverseerRun",
		},
		opts = {
			templates = { "builtin", "node" },
			task_list = {
				direction = "bottom",
				bindings = {
					["?"] = "ShowHelp",
					["g?"] = "ShowHelp",
					["<CR>"] = "RunAction",
					["<C-e>"] = "Edit",
					["o"] = "Open",
					["<C-v>"] = "OpenVsplit",
					["<C-s>"] = "OpenSplit",
					["<C-f>"] = "OpenFloat",
					["<C-q>"] = "OpenQuickFix",
					["p"] = "TogglePreview",
					["<tab>"] = "IncreaseDetail",
					["<s-tab>"] = "DecreaseDetail",
					["L"] = "IncreaseAllDetail",
					["H"] = "DecreaseAllDetail",
					["["] = "DecreaseWidth",
					["]"] = "IncreaseWidth",
					["{"] = "PrevTask",
					["}"] = "NextTask",
					["<C-u>"] = "ScrollOutputUp",
					["<C-d>"] = "ScrollOutputDown",
					["q"] = "Close",
				},
			},
		},
		dependencies = {
			{
				"pianocomposer321/officer.nvim",
				opts = {},
			},
		},
	},
	{
		"ej-shafran/compile-mode.nvim",
		branch = "latest",
		cmd = "Compile",
		keys = {
			{ "<leader>cc", cmd("Compile"), desc = "Compile" },
			{ "<leader>cr", cmd("Recompile"), desc = "Recompile" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		opts = {
			default_command = "ruby",
		},
	},
}
