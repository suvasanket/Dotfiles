require("core.helper")
return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
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
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-t>"] = {
					"actions.select",
					opts = {
						close = true,
						tab = true,
					},
				},
				["<leader>p"] = "actions.preview",
				["<C-h>"] = false,
				["<C-l>"] = false,
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
					-- local file = oil.get_cursor_entry().name
					if cwd and pattern then
						local full_path = cwd .. pattern
						vim.api.nvim_feedkeys(": " .. full_path, "n", false)
						vim.schedule(function()
							vim.api.nvim_input("<Home>!")
							require("oil.actions").refresh.callback()
						end)
					end
				end,
				["<leader>tt"] = "actions.open_terminal",
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
