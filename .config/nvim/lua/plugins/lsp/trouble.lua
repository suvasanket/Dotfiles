---@diagnostic disable: unused-local
return {
	"folke/trouble.nvim",
	event = "LspAttach",
	opts = {
		-- severity = vim.diagnostic.severity.ERROR, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
		padding = false, -- add an extra new line on top of the list
		auto_close = false,
		auto_open = false,
		indent_lines = false, -- add an indent guide below the fold icons
		signs = {
			error = "",
			warning = "",
			hint = "",
			information = "",
			other = "",
		},
		action_keys = {
			open_split = { "<c-s>" },
			-- toggle_fold = { "za", "<tab>" }, -- toggle fold of current file
		},
	},
	keys = {
		{ "<leader>qf", "<cmd>TroubleToggle quickfix<cr>", desc = "quickfix" },
		{
			"[q",
			function()
				if require("trouble").is_open() then
					require("trouble").previous({ skip_groups = true, jump = true })
				else
					local ok, result = pcall(vim.cmd, "cprev")
					if not ok then
						ok, result = pcall(vim.cmd, "clast")
						if not ok then
							print("qf re kichi nahi")
						end
					end
				end
			end,
			desc = "Previous trouble/quickfix item",
		},
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, result = pcall(vim.cmd, "cnext")
					if not ok then
						ok, result = pcall(vim.cmd, "cfirst")
						if not ok then
							print("qf re kichi nahi")
						end
					end
				end
			end,
			desc = "Next trouble/quickfix item",
		},
		{
			"[d",
			function()
				if require("trouble").is_open() then
					require("trouble").previous({ skip_groups = true, jump = true })
				end
			end,
			desc = "prev diagnostic item",
		},
		{
			"]d",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				end
			end,
			desc = "next diagnostic item",
		},
	},
}
