require("core.helper")
return {
	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = {
			"Telescope",
		},
		dependencies = {
			{
				"danielfalk/smart-open.nvim",
				dependencies = {
					{ "kkharji/sqlite.lua" },
				},
			},
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		--stylua: ignore
		keys = {
			{"<leader>'", "<cmd>Telescope resume<cr>", desc = "Telescope resume"},
			{ "<C-S-\\>", cmd_tele("commands") },
			{
				"<C-f>",
				function()
					require("telescope").extensions.smart_open.smart_open({
						cwd_only = false,
						prompt_title = false,
						preview_title = false,
						result_title = false,
						prompt_prefix = " ~/ ",
						theme = "dropdown",
						layout_config = {
							preview_width = 0.5,
						}
					})
				end,
				desc = "smart_open",
			},
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
			{ "<leader>fc", cmd_tele("find_files"), desc = "find_files" },
			{ "<leader>fg", cmd_tele("live_grep"), desc = "Live_grep" },
			{ "<leader>fd", cmd_tele("fd cwd=$HOME find_command=fd,-t=d,-H disable_devicons=true previewer=false"), desc = "find dir" },
			--git
			{ "<leader>gb", cmd_tele("git_branches"), desc = "git branches" },
			{ "<leader>gf", cmd_tele("git_files"), desc = "git files" },
			{ "<leader>gc", cmd_tele("git_commits"), desc = "git commits" },
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
					smart_open = {
						match_algorithm = "fzf",
						prompt_prefix = " l ",
					},
					fzf = {
						override_generic_sorter = true,
						override_file_sorter = true,
					},
				},
			})
		end,
	},
}
