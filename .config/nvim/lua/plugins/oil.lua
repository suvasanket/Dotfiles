require("core.helper")
local detail = false

return {
	"stevearc/oil.nvim",
    lazy = false,
	keys = {
		{ "-", "<cmd>Oil<cr>" },
	},
	config = function()
		local oil = require("oil")
		local function GetCurrentEntryPath()
			local cwd = oil.get_current_dir()
			local line = vim.fn.getline(".")
			local pattern = line:match("[%S]+%s+[%S]+%s+(.*)")
			if cwd and pattern then
				return cwd .. pattern
			end
		end
		oil.setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["gh"] = "<cmd>edit $HOME<CR>",
                ["gj"] = "<cmd>edit ~/Developer/<CR>",
				["gl"] = "<cmd>edit $HOME/Downloads/<CR>",

				["<tab>"] = {
					desc = "Toggle file detail view",
					callback = function()
						detail = not detail
						if detail then
							oil.set_columns({ "icon", "permissions", "size", "mtime" })
						else
							oil.set_columns({ "icon" })
						end
					end,
				},
				["U"] = function()
					oil.discard_all_changes()
				end,
				["!"] = function()
					vim.api.nvim_feedkeys(": " .. GetCurrentEntryPath(), "n", false)
					vim.schedule(function()
						vim.api.nvim_input("<Home>")
						require("oil.actions").refresh.callback()
					end)
				end,
				["yp"] = {
					desc = "Copy filepath to system clipboard",
					callback = function()
						require("oil.actions").copy_entry_path.callback()
						vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
					end,
				},
			},

			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					if name == ".DS_Store" then
						return true
					else
						return false
					end
				end,
			},
		})
	end,
}
