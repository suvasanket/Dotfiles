return {
	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim" },
				sync_install = true,
				auto_install = true,
				ignore_install = {},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-k>",
						node_incremental = "<C-k>",
						node_decremental = "<C-j>",
						scope_incremental = "<cr>",
					},
				},
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
				markid = { enable = true },
			})
		end,
		dependencies = {
			{ "David-Kunz/markid" },
		},
	},
}
