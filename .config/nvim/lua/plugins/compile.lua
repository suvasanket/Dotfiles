require("core.helper")

return {
	{
		"ej-shafran/compile-mode.nvim",
		branch = "latest",
		keys = {
			{
				"<leader>ac",
				function()
                    local current_file = vim.fn.expand("%")
                    local perCMD = require("core.perCMD")

                    local CMD = perCMD.getprojectCMD(current_file:gsub("%.", "_"))
                    if not CMD then
                        CMD = perCMD.getcompilerCMD(current_file, vim.bo.filetype)
                    end

                    local input = UserInput(":Term ", CMD)
                    if input then
                        perCMD.setprojectCMD(current_file:gsub("%.", "_"), input)
                        perCMD.setcompilerCMD(vim.bo.filetype, input:gsub(vim.fn.expand("%:r"), "{filename}"))
                        vim.cmd("Compile " .. input)
                    end
					TerminalCommandType = "Recompile"
				end,
			},
		},
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
