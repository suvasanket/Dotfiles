require("core.helper")

return {
	--Telescope
	{
		'nvim-telescope/telescope.nvim',
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "stevearc/quicker.nvim" },
			{
				"danielfalk/smart-open.nvim",
				dependencies = {
					{ "kkharji/sqlite.lua" },
				},
			},
		},
		keys = {
			{ "<C-S-\\>", Telescope("builtin") },
			{ "<leader>sh", Telescope("help_tags"), desc = "help_tags" },
			{ "zc", Telescope("buffers"), desc = "buffers" },
			{ "<leader>/", Telescope("current_buffer_fuzzy_find"), desc = "current_buffer_fuzzy_find" },
			{ "<C-Cr>", Telescope("lsp_dynamic_workspace_symbols"), desc = "Workspace_symbols" },
			{ "<leader>ff", Telescope("fd cwd=$HOME find_command=fd,-t=f,-H prompt_prefix=\\ ~/\\ "), desc = "find_files" },
			{ "<leader>fc", Telescope("fd cwd=~/dotfiles/ find_command=fd,-t=f,-H"), desc = "config" },
			{ "<leader>fd", Telescope("fd cwd=$HOME find_command=fd,-t=d,-H disable_devicons=true previewer=false"), desc = "find dir" },
			{ "<leader>gb", Telescope("git_branches") },

			-- smart find
			{ "<C-f>", function()
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")
					local function open_find()
						local working_dir = GetProjectRoot()
						vim.cmd("cd " .. working_dir)
						require("telescope").extensions.smart_open.smart_open({
							cwd_only = true,
							filename_first = false,
							prompt_title = false,
							preview_title = false,
							result_title = false,
							disable_devicons = true,
							attach_mappings = function(_, map)
								map({"i", "n"}, "<C-c>", function(_prompt_bufnr)
									actions.close(_prompt_bufnr)
								end, { desc = "close"})
								map({"i", "n"}, "<C-o>", function()
									local entry = action_state.get_current_line()
									require("telescope.builtin").oldfiles({
										prompt_title = false,
										preview_title = false,
										result_title = false,
										default_text = entry,
										disable_devicons = true,
										attach_mappings = function(_, sap)
											sap({"i", "n"}, "<C-f>", function()
												open_find()
											end)
											return true
										end
									})
								end, { desc = "close"})
								map({"i", "n"}, "<C-g>", function()
									local entry = action_state.get_current_line()
									require("telescope.builtin").find_files({
										cwd = "~/",
										prompt_title = false,
										preview_title = false,
										result_title = false,
										default_text = entry,
										disable_devicons = true,
										attach_mappings = function(_, sap)
											sap({"i", "n"}, "<C-f>", function()
												open_find()
											end)
											return true
										end
									})
								end, { desc = "Global search"})
								return true
							end,
						})
					end
					open_find()
				end
			},

			{ "<leader>fg", function ()
				local working_dir = GetProjectRoot()
				print("searching in:" .. working_dir)
				require("telescope.builtin").live_grep({
					cwd =  working_dir,
					additional_args = function()
						return {"--hidden"}
					end,
					filename_first = false,
					prompt_title = false,
					preview_title = false,
					result_title = false,
				})
			end, desc = "Live_grep" },
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
					borderchars = {
						prompt = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
						results = { " ", "▐", "▄", "▌", "▌", "▐", "▟", "▙" },
						preview = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
					},
					previewer = false,
					results_title = false,
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
						n = {
							["q"] = require("telescope.actions").close,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true
					},
					lsp_references = {
						theme = "ivy",
						prompt_prefix = "󱪙  ",
						initial_mode = "normal",
						borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
						layout_config = {
							height = 0.4,
							width = 0.3,
							preview_width = 0.7,
						},
					}
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
					smart_open = {
						match_algorithm = "fzf",
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
}
