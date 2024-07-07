return {
	{
		"echasnovski/mini.indentscope",
		event = "Filetype",
		config = function()
			require("mini.indentscope").setup({
				-- Draw options
				draw = {
					delay = 100,
					priority = 2,
				},

				mappings = {
					object_scope = "ii",
					object_scope_with_border = "ai",
					goto_top = "[i",
					goto_bottom = "]i",
				},

				options = {
					border = "both",
					indent_at_cursor = true,
					try_as_border = false,
				},

				symbol = "│",
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "Filetype",
		config = function()
			require("ufo").setup({
				close_fold_kinds_for_ft = {
					default = { "imports", "comment" },
					json = { "array" },
					c = { "comment", "region" },
				},
				enable_get_fold_virt_text = true,

				---@diagnostic disable-next-line: unused-local
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{
		"tzachar/highlight-undo.nvim",
		event = "BufReadPost",
		keys = {
			{ "u" },
			{ "<C-r>" },
		},
		opts = {
			duration = 2000,
		},
	},

	{
		"nvimdev/hlsearch.nvim",
		event = "BufRead",
		config = function()
			require("hlsearch").setup()
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		event = "LspAttach",
		opts = {
			cmd_name = "Rename",
			save_in_cmdline_history = false,
		},
	},

	{
		"echasnovski/mini.trailspace",
		event = "BufRead",
		keys = { { "<leader>bt", "<cmd>lua MiniTrailspace.trim()<cr>", desc = "trim whitespaces" } },
		config = function()
			require("mini.trailspace").setup({
				only_in_normal_buffers = true,
			})
		end,
	},
}
