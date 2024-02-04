return {
	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"danielfalk/smart-open.nvim",
				dependencies = { "kkharji/sqlite.lua" },
			},
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		--stylua: ignore
		keys = {
			{ "<C-f>", function()
				require("telescope").extensions.smart_open.smart_open({
					attach_mappings = function(_, map)
						map({"i", "n"}, "<C-f>", function()
							vim.cmd("q!")
						end)
						return true
					end,
					search_dirs = { "~/" },
					cwd_only = false,
					filename_first = true,
					previewer = true,
					-- layout_config = { width = 0.6, height = 0.4 },
				})
			end, desc = "smart_open" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "CommandHist" },
			{ "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "CommandHist" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Oldfiles" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Findfiles" },
			{ "<leader>bs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symbols" },
			{ "<leader>bg", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "current_buffer_fuzzy_find" },
			{ "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace_symbols" },
			{ "<leader>wg", "<cmd>Telescope grep_string<cr>", desc = "Live_grep" },
			{ "<leader>wd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "git branches" },
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "git files" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "git commits" },
			{ "<leader>f" ,"<cmd>Telescope<cr>"},
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
					find_files = {
						previewer = true,
						hidden = true,
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
				extensions = {},
			})
			require("telescope").load_extension("smart_open")
		end,
	},
}
