return {
	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "javascript", "java", "html", "css", "vim", "c" },
				sync_install = true,
				auto_install = true,
				ignore_install = {},
				highlight = {
					enable = true,
					---@diagnostic disable-next-line: unused-local
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					additional_vim_regex_highlighting = true,
				},
				--text-object
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader><leader>a"] = { query = "@parameter.inner", desc = "swap parameter next" },
						},
						swap_previous = {
							["<leader><leader>A"] = { query = "@parameter.inner", desc = "swap parameter next" },
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next = {
							["]m"] = { query = "@function.*", desc = "next function" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "next fold" },
						},
						goto_previous = {
							["[m"] = { query = "@function.*", desc = "prev function" },
							["[z"] = { query = "@fold", query_group = "folds", desc = "prev fold" },
						},
					},
				},
				markid = { enable = true },
			})
		end,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "David-Kunz/markid" },
		},
	},
}
