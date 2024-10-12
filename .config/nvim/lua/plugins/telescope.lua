require("core.helper")
local function get_wd()
	local workspace = vim.lsp.buf.list_workspace_folders()
	local wd = nil
	local v = vim

	if workspace[1] ~= nil then
		wd = workspace[1]
	else
		local git_root = v.fn.systemlist("git rev-parse --show-toplevel")
		if v.v.shell_error == 0 then
			wd = git_root
		end
	end
	return wd
end

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
			{ "<leader>'", "<cmd>Telescope resume<cr>", desc = "Telescope resume" },
			{ "<C-S-\\>", cmd_tele("commands") },
			--search
			{ "<leader>ss", cmd_tele("builtin") },
			{ "<leader>sh", cmd_tele("help_tags"), desc = "help_tags" },
			{ "<leader>s;", cmd_tele("command_history"), desc = "CommandHist" },
			{ "<leader>so", cmd_tele("oldfiles"), desc = "Oldfiles" },
			{ "<leader>sm", cmd_tele("man_pages"), desc = "Unix_Manuals" },
			--buffer
			{ "zc", cmd_tele("buffers"), desc = "Symbols" },
			{ "<leader>cs", cmd_tele("lsp_document_symbols"), desc = "Symbols" },
			{ "<leader>/", cmd_tele("current_buffer_fuzzy_find"), desc = "current_buffer_fuzzy_find" },
			--find
			{ "<leader>ws", cmd_tele("lsp_workspace_symbols"), desc = "Workspace_symbols" },
			{ "<leader>ff", cmd_tele("fd cwd=$HOME find_command=fd,-t=f,-H prompt_prefix=\\ ~/\\ "), desc = "find_files" },
			{ "<leader>fc", cmd_tele("fd cwd=~/dotfiles/ find_command=fd,-t=f,-H"), desc = "config" },
			{ "<leader>fd", cmd_tele("fd cwd=$HOME find_command=fd,-t=d,-H disable_devicons=true previewer=false"), desc = "find dir" },
			--git
			{ "<leader>gb", cmd_tele("git_branches"), desc = "git branches" },
			{ "<leader>gf", cmd_tele("git_files"), desc = "git files" },

			-- smart find
			{ "<C-f>", function()
					local working_dir = get_wd()
					vim.cmd("cd " .. working_dir)
					require("telescope").extensions.smart_open.smart_open({
						cwd_only = true,
						filename_first = false,
						prompt_title = false,
						preview_title = false,
						result_title = false,
						attach_mappings = function(_, map)
							map({"i", "n"}, "<C-g>", function()
								require("telescope.builtin").find_files({
									cwd = "~/",
									prompt_title = false,
									preview_title = false,
									result_title = false,
								})
							end, { desc = "Global search"})
							return true
						end,
					})
				end
			},

			{ "<leader>fg", function ()
				local working_dir = get_wd()
				require("telescope.builtin").live_grep({
					cwd =  working_dir,
					additional_args = function(opts)
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
						n = {
							["q"] = require("telescope.actions").close,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true
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
