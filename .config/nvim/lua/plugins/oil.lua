return {
	"stevearc/oil.nvim",
	enabled = true,
	lazy = false,
	keys = {
		{ "-", "<cmd>Oil --float<cr>" },
	},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			cleanup_delay_ms = 200,
			columns = {
				-- "permissions",
				"icon",
				-- "size",
				-- "mtime",
			},
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
				number = true,
				relativenumber = true,
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["h"] = "actions.parent",
				["l"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<leader>p"] = "actions.preview",
				["<C-h>"] = false,
				["<C-l>"] = false,
				["q"] = "actions.close",
				["<D-r>"] = "actions.refresh",
				["<bs>"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["go"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
				["<C-c>"] = false,
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
