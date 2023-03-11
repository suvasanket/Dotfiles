return {
	--mini autopairs
	{
		"echasnovski/mini.pairs",
		event = "BufRead",
		config = function()
			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = true },
			})
		end,
	},

	--MiniComment
	{
		"echasnovski/mini.comment",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
		event = "BufRead",
		config = function()
			require("mini.comment").setup({ options = { ignore_blank_line = true } })
		end,
	},

	--miniSorround
	{
		"echasnovski/mini.surround",
		event = "BufRead",
		config = function()
			require("mini.surround").setup()
		end,
	},
	--mini-indentscope
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "NvimTree", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},

	--mini-animate
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		config = function()
			require("mini.animate").setup({
				scroll = { enable = false },
			})
		end,
	},

	--mini-f
	{
		"echasnovski/mini.jump",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.jump").setup()
		end,
	},

	--mini-bracketed
	{
		"echasnovski/mini.bracketed",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.bracketed").setup({ diagnostic = { suffix = "", options = {} } })
		end,
	},

	--mini-ai
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		event = "VeryLazy",
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},
}
