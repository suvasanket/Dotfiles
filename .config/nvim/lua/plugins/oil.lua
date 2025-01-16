require("core.helper")
return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	keys = {
		{ "-", "<cmd>Oil<cr>" },
	},
	config = function()
		local oil = require("oil")
		oil.setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["h"] = "actions.parent",
				["l"] = "actions.select",
				["<C-v>"] = {
					"actions.select",
					opts = { vertical = true, close = true },
					desc = "Open the entry in a vertical split",
				},
				["<C-s>"] = {
					"actions.select",
					opts = { horizontal = true, close = true },
					desc = "Open the entry in a horizontal split",
				},
				["<C-t>"] = {
					"actions.select",
					opts = { tab = true, close = true },
					desc = "Open the entry in new tab",
				},
				["<C-p>"] = "actions.preview",
				["q"] = "actions.close",
				["<leader>xx"] = "actions.refresh",
				["<C-d>"] = "actions.preview_scroll_down",
				["<C-u>"] = "actions.preview_scroll_up",

				["gt"] = "actions.toggle_trash",
				["gh"] = "<cmd>edit $HOME<CR>",
				["gl"] = "<cmd>edit $HOME/Downloads/<CR>",

				["<C-c>"] = false,
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
				["."] = function()
					local cwd = oil.get_current_dir()
					local line = vim.fn.getline(".")
					local pattern = line:match("[%S]+%s+[%S]+%s+(.*)")
					if cwd and pattern then
						local full_path = cwd .. pattern
						vim.api.nvim_feedkeys(": " .. full_path, "n", false)
						vim.schedule(function()
							vim.api.nvim_input("<Home>")
							require("oil.actions").refresh.callback()
						end)
					end
				end,
				["<leader>tt"] = "actions.open_terminal",
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
