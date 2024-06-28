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
						patterns = { ".git", "Gemfile", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
					})
				end,
			},
		},
		--stylua: ignore
		keys = {
			{ "<C-f>","<cmd>Telescope smart_open smart_open theme=ivy previewer=false<cr>", desc = "smart_open" },
			--search
			{ "<leader>s",  "<cmd>Telescope<cr>" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>",                           desc = "help_tags" },
			{ "<leader>s;", "<cmd>Telescope command_history<cr>",                     desc = "CommandHist" },
			{ "<leader>so", "<cmd>Telescope oldfiles<cr>",                            desc = "Oldfiles" },
			--buffer
			{ "<leader>b",  "<cmd>Telescope buffers<cr>",                             desc = "Symbols" },
			{ "<leader>bs", "<cmd>Telescope lsp_document_symbols<cr>",                desc = "Symbols" },
			{ "<leader>bg", "<cmd>Telescope current_buffer_fuzzy_find<cr>",           desc = "current_buffer_fuzzy_find" },
			--find
			{ "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>",desc = "Workspace_symbols" },
			{ "<leader>ff", "<cmd>Telescope smart_open smart_open cwd_only=true<cr>", desc = "find_files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>",desc = "Live_grep" },
			{ "<leader>fd", "<cmd>Telescope fd cwd=$HOME find_command=fd,-t=d,-H disable_devicons=true previewer=false prompt_title=false<cr>",desc = "find dir" },
			--git
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>",desc = "git branches" },
			{ "<leader>gf", "<cmd>Telescope git_files<cr>",desc = "git files" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>",desc = "git commits" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						height = 0.8,
						width = 0.7,
						horizontal = {
							prompt_position = "top",
						},
					},
					sorting_strategy = "ascending",
					prompt_title = false,
					preview_title = false,
					prompt_prefix = "> ",
					selection_caret = " ",
					mappings = {
						n = {
							["q"] = require("telescope.actions").close,
						},
						i = {
							["<C-[>"] = require("telescope.actions").close,
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
						},
					},
				},
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
					find_files = {
						previewer = true,
						hidden = true,
						mappings = {
							i = {
								-- ["<CR>"] = require("telescope.actions").select_tab_drop,
							},
						},
					},
					git_commits = {
						theme = "dropdown",
						layout_config = {
							height = 0.4,
						},
					},
					git_branches = {
						theme = "dropdown",
						layout_config = {
							height = 0.4,
						},
					},
					grep_string = {
						layout_config = {
							preview_width = 0.6,
						},
					},
					current_buffer_fuzzy_find = {
						layout_config = {
							preview_width = 0.6,
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
