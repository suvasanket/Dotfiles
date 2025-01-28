local function find_in(wd)
	local inf = math.huge
	local sort = MiniVisits.gen_sort.z()
	local visit_paths = MiniVisits.list_paths(nil, { sort = sort })

	visit_paths = vim.tbl_map(function(path)
		return path:sub(#wd + 2) -- Remove root_path and the trailing slash
	end, visit_paths)
	vim.tbl_add_reverse_lookup(visit_paths)
	-- current file last
	local current_file = vim.fn.expand("%:p")
	current_file = current_file:sub(#wd + 2)
	if visit_paths[current_file] then
		visit_paths[current_file] = inf
	end

	MiniPick.builtin.files({ tools = "fd" }, {
		source = {
			cwd = wd,
			name = vim.fs.basename(wd),
			match = function(stritems, indices, query)
				local filtered = MiniPick.default_match(stritems, indices, query, { sync = true }) or {}

				table.sort(filtered, function(item1, item2)
					local path1 = stritems[item1]
					local path2 = stritems[item2]
					local score1 = visit_paths[path1] or inf -- inf for paths not visited
					local score2 = visit_paths[path2] or inf -- inf for paths not visited
					return score1 < score2
				end)

				return filtered
			end,
		},
		mappings = {
			string = {
				char = "<C-'>",
				func = function()
					require("mini.pick").builtin.grep_live(nil, {
						source = { cwd = wd },
					})
				end,
			},
			hidden = {
				char = "<C-;>",
				func = function()
					require("mini.pick").builtin.cli({ command = { "fd", "-H" } }, {
						source = { cwd = wd },
					})
				end,
			},
			old = {
				char = "<C-o>",
				func = function()
					require("mini.extra").pickers.oldfiles()
				end,
			},
		},
	})
end

local mark_and_move_down = function()
	local mappings = MiniPick.get_picker_opts().mappings
	local keys = mappings.mark .. mappings.move_down
	vim.api.nvim_input(vim.api.nvim_replace_termcodes(keys, true, true, true))
end

return {
	"echasnovski/mini.pick",
	dependencies = {
		"echasnovski/mini.extra",
	},
	cmd = "Pick",
	lazy = true,
	keys = {
		{ "<C-'>", "<cmd>Pick grep_live<cr>", desc = "live grep" },
		{ "<leader>ff", "<cmd>Pick frecency<cr>", desc = "find files" },
		{ "<leader>sh", "<cmd>Pick help<cr>" },
		{ "<leader>sk", "<cmd>Pick keymaps<cr>" },
		{
			"<leader>fc",
			"<cmd>lua MiniPick.builtin.files({tool = 'fd'}, { source = { cwd = '~/.config' } })<cr>",
			desc = "config",
		},
		{
			"<C-f>",
			function()
				-- function call
				if vim.fn.getcwd() == os.getenv("HOME") then
					require("mini.extra").pickers.oldfiles()
				else
					find_in(GetProjectRoot())
				end
			end,
			desc = "find files",
		},
	},
	config = function()
		require("mini.pick").setup({
			mappings = {
				delete_char = "<C-h>",
				choose_marked = "<C-q>",

				toggle_preview = "<C-p>",
				mark_and_down = { char = "<tab>", func = mark_and_move_down },
				mark_all = "<C-space>",
				refine = "<C-l>",
				refine_marked = "<C-s-l>",

				move_down = "<C-j>",
				move_start = "<C-g>",
				move_up = "<C-k>",

				choose_in_split = "",
				scroll_down = "",
				scroll_left = "",
				scroll_right = "",
				scroll_up = "",
			},
			window = {
				prompt_cursor = "🭳",
				prompt_prefix = "",
			},
		})
		MiniPick = require("mini.pick")
		MiniVisits = require("mini.visits")
		MiniPick.registry.frecency = function()
			local inf = math.huge

			local sort = MiniVisits.gen_sort.z()
			local visit_paths = MiniVisits.list_paths(nil, { sort = sort })
			visit_paths = vim.tbl_map(function(path)
				return vim.fn.fnamemodify(path, ":.")
			end, visit_paths)
			vim.tbl_add_reverse_lookup(visit_paths)

			-- current file last
			local current_file = vim.fn.expand("%:.")
			if visit_paths[current_file] then
				visit_paths[current_file] = inf
			end

			MiniPick.builtin.files(nil, {
				source = {
					name = "Files",
					match = function(stritems, indices, query)
						local filtered = MiniPick.default_match(stritems, indices, query, { sync = true }) or {}

						table.sort(filtered, function(item1, item2)
							local path1 = stritems[item1]
							local path2 = stritems[item2]
							local score1 = visit_paths[path1] or inf -- inf for paths not visited
							local score2 = visit_paths[path2] or inf -- inf for paths not visited
							return score1 < score2
						end)

						return filtered
					end,
				},
			})
		end
	end,
}
