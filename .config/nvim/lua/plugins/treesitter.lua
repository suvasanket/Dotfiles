return {
	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufRead", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim" },
				incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "s",
                        node_incremental = "s",
                        node_decremental = "S",
						scope_incremental = "+",
					},
				},
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					additional_vim_regex_highlighting = true,
				},
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader><leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader><leader>A"] = "@parameter.inner",
                        },
                    },
                }
			})
		end,
	},
}
