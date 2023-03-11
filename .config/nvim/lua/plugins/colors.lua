return {
	--Colorscheme
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "transparent",
					floats = "normal",
				},
				sidebars = {},
			})
		end,
	},

	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "javascript", "lua", "vim", "help", "query" },
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				highlight = {
					enable = true,
					-- disable = { "c", "rust" },
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	--Treesitter-Textobject
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		init = function()
			-- PERF: no need to load the plugin, if we only need its queries for mini.ai
			local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local enabled = false
			if opts.textobjects then
				for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
					if opts.textobjects[mod] and opts.textobjects[mod].enable then
						enabled = true
						break
					end
				end
			end
			if not enabled then
				require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
			end
		end,
	},
}
