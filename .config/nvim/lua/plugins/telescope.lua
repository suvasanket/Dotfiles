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
			{
				"ahmedkhalf/project.nvim",
				event = { "VeryLazy" },
				config = function()
					require("project_nvim").setup({
						detection_methods = { "lsp", "pattern" },
						patterns = { ".git", "Gemfile", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
					})
				end,
			},
		},
		--stylua: ignore
		keys = {
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
			{
				"<leader>s",
				"<cmd>Telescope builtin prompt_title=false preview_title=false result_title=false<cr>",
			},
			{
				"<leader>sh",
				"<cmd>Telescope help_tags prompt_title=false preview_title=false result_title=false<cr>",
				desc = "help_tags",
			},
			{
				"<leader>s;",
				"<cmd>Telescope command_history prompt_title=false preview_title=false result_title=false<cr>",
				desc = "CommandHist",
			},
			{
				"<leader>so",
				"<cmd>Telescope oldfiles prompt_title=false preview_title=false result_title=false<cr>",
				desc = "Oldfiles",
			},
			--buffer
			{
				"zc",
				"<cmd>Telescope buffers theme=ivy layout_config={height=0.4} previewer=false prompt_title=false preview_title=false result_title=false<cr>",
				desc = "Symbols",
			},
			{
				"<leader>bs",
				"<cmd>Telescope lsp_document_symbols prompt_title=false preview_title=false result_title=false<cr>",
				desc = "Symbols",
			},
			{
				"<leader>bg",
				"<cmd>Telescope current_buffer_fuzzy_find prompt_title=false preview_title=false result_title=false<cr>",
				desc = "current_buffer_fuzzy_find",
			},
			--find
			{
				"<leader>ws",
				"<cmd>Telescope lsp_workspace_symbols prompt_title=false preview_title=false result_title=false<cr>",
				desc = "Workspace_symbols",
			},
			{

				"<leader>ff",
				function()
					require("telescope").extensions.smart_open.smart_open({
						cwd_only = true,
						prompt_title = false,
						preview_title = false,
						result_title = false,
						prompt_prefix = " 󰱼 ",
						layout_config = {
							preview_width = 0.5,
						}
					})
				end,
				desc = "find_files",
			},
			{
				"<leader>fc",
				"<cmd>Telescope find_files prompt_title=false preview_title=false result_title=false<cr>",
				desc = "find_files",
			},
			{
				"<leader>fg",
				"<cmd>Telescope live_grep prompt_title=false preview_title=false result_title=false<cr>",
				desc = "Live_grep",
			},
			{
				"<leader>fd",
				"<cmd>Telescope fd cwd=$HOME find_command=fd,-t=d,-H disable_devicons=true previewer=false prompt_title=false preview_title=false result_title=false<cr>",
				desc = "find dir",
			},
			--git
			{
				"<leader>gb",
				"<cmd>Telescope git_branches prompt_title=false preview_title=false result_title=false<cr>",
				desc = "git branches",
			},
			{
				"<leader>gf",
				"<cmd>Telescope git_files prompt_title=false preview_title=false result_title=false<cr>",
				desc = "git files",
			},
			{
				"<leader>gc",
				"<cmd>Telescope git_commits prompt_title=false preview_title=false result_title=false<cr>",
				desc = "git commits",
			},
		},
		config = function()
			require('telescope.pickers.layout_strategies').horizontal_merged = function(picker, max_columns, max_lines, layout_config)
				local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns, max_lines, layout_config)
				layout.results.line = layout.results.line - 1
				layout.results.height = layout.results.height + 1
				-- layout.results.title = ''
				return layout
			end
			require("telescope").setup({
				defaults = {
					winblend = 5;
					prompt_title = false,
					results_title = false,
					preview_title = false,
					borderchars = {
						prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
						results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' };
						preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
					},
					previewer = false;
					layout_strategy = 'horizontal_merged',
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
							["<C-u>"] = false
						},
					},
				},
				extensions = {
					smart_open = {
						match_algorithm = "fzf",
					},
					projects = {},
					fzf = {
						override_generic_sorter = true,
						override_file_sorter = true,
					},
				},
			})
		end,
	},
}
