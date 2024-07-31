require("core.helper")
return {
	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = {
			"Telescope",
		},
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-frecency.nvim" },
		},
		keys = {
			{ "<leader>'", "<cmd>Telescope resume<cr>", desc = "Telescope resume" },
			{ "<C-S-\\>", cmd_tele("commands") },
			{ "<C-f>", cmd_tele("frecency workspace=home"), desc = "home find file" },
			--search
			{ "<leader>ss", cmd_tele("builtin") },
			{ "<leader>sh", cmd_tele("help_tags"), desc = "help_tags" },
			{ "<leader>s;", cmd_tele("command_history"), desc = "CommandHist" },
			{ "<leader>so", cmd_tele("oldfiles"), desc = "Oldfiles" },
			--buffer
			{ "zc", cmd_tele("buffers"), desc = "Symbols" },
			{ "<leader>bs", cmd_tele("lsp_document_symbols"), desc = "Symbols" },
			{ "<leader>/", cmd_tele("current_buffer_fuzzy_find"), desc = "current_buffer_fuzzy_find" },
			--find
			{ "<leader>ws", cmd_tele("lsp_workspace_symbols"), desc = "Workspace_symbols" },
			{ "<leader>ff", cmd_tele("frecency workspace=CWD"), desc = "find_files" },
			{ "<leader>fc", cmd_tele("frecency workspace=config"), desc = "config" },
			{ "<leader>fg", cmd_tele("live_grep"), desc = "Live_grep" },
			{ "<leader>fd", cmd_tele("fd cwd=$HOME find_command=fd,-t=d,-H disable_devicons=true previewer=false"), desc = "find dir" },
			--git
			{ "<leader>gb", cmd_tele("git_branches"), desc = "git branches" },
			{ "<leader>gf", cmd_tele("git_files"), desc = "git files" },
		},
		config = function()
			require("telescope.pickers.layout_strategies").horizontal_merged = function(
				picker,
				max_columns,
				max_lines,
				layout_config
			)
				local layout = require("telescope.pickers.layout_strategies").horizontal(
					picker,
					max_columns,
					max_lines,
					layout_config
				)
				layout.results.line = layout.results.line - 1
				layout.results.height = layout.results.height + 1
				-- layout.results.title = ''
				return layout
			end
			require("telescope").setup({
				defaults = {
					winblend = 5,
					prompt_title = false,
					results_title = false,
					preview_title = false,
					borderchars = {
						prompt = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
						results = { " ", "▐", "▄", "▌", "▌", "▐", "▟", "▙" },
						preview = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
					},
					previewer = false,
					layout_strategy = "horizontal_merged",
					layout_config = {
						height = 0.6,
						width = 0.7,
						-- preview_width = 0.5,
						horizontal = {
							prompt_position = "top",
						},
					},
					sorting_strategy = "ascending",
					preview = {
						filesize_limit = 0.3,
					},
					prompt_prefix = "  ",
					selection_caret = "  ",
					mappings = {
						i = {
							["<C-[>"] = require("telescope.actions").close,
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
							["<C-u>"] = false,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
					frecency = {
						sorter = require("telescope").extensions.fzf.native_fzf_sorter(),
						hide_current_buffer = true,
						path_display = { "tail" },
						workspaces = {
							["home"] = "/Users/suvasanketrout/",
							["config"] = "/Users/suvasanketrout/.config/nvim/",
							["codes"] = "/Users/suvasanketrout/codes/"
						}
					},
				},
			})
			require("telescope").load_extension("frecency")
			require('telescope').load_extension('fzf')
		end,
	},
}
