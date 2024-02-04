return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.register({
			["z"] = {
				["x"] = { name = "kill-buffer" },
			},
			["<leader>"] = {
				["<leader>"] = { name = "+swap" },
				q = { name = "+macro/session" },
				r = { name = "+run" },
				w = {
					name = "+workspace",
					l = { "list_workspace_folders" },
					a = { "add_workspace_folder" },
					r = { "remove_workspace_folder" },
				},
				c = {
					name = "+code",
				},
				g = { name = "+git" },
				d = { name = "+dap" },
				b = { name = "+buffer" },
				n = { name = "+notes" },
				f = { name = "+find" },
				m = { name = "+refactor" },
				k = "signature_help",
			},
			["g"] = {
				c = { "Line-comment" },
				b = { "Block-comment" },
				d = { "Definition" },
				D = { "Declaration" },
				r = { "Reference" },
				i = { "Implementation" },
				t = {
					name = "type",
					d = { "Definition" },
				},
			},
			["v"] = {
				i = {
					a = { "InsideArgument" },
					f = { "InsideFunction" },
					c = { "InsideClass " },
					o = { "InsideBlocks" },
					n = {
						name = "next",
						a = { "nextInsideArgument" },
						f = { "nextInsideFunction" },
						c = { "nextInsideClass " },
						o = { "nextInsideBlocks" },
					},
				},
				a = {
					a = { "AroundArgument" },
					f = { "AroundFunction" },
					c = { "AroundClass " },
					o = { "AroundBlocks" },
					n = {
						name = "next",
						a = { "nextAroundArgument" },
						f = { "nextAroundFunction" },
						c = { "nextAroundClass " },
						o = { "nextAroundBlocks" },
					},
				},
			},
			["y"] = {
				i = {
					a = { "AroundArgument" },
					f = { "AroundFunction" },
					c = { "AroundClass " },
					o = { "AroundBlocks" },
					n = {
						a = { "nextAroundArgument" },
						f = { "nextAroundFunction" },
						c = { "nextAroundClass " },
						o = { "nextAroundBlocks" },
					},
				},
				a = {
					a = { "AroundArgument" },
					f = { "AroundFunction" },
					c = { "AroundClass " },
					o = { "AroundBlocks" },
					n = {
						name = "next",
						a = { "nextAroundArgument" },
						f = { "nextAroundFunction" },
						c = { "nextAroundClass " },
						o = { "nextAroundBlocks" },
					},
				},
			},
			["d"] = {
				i = {
					a = { "AroundArgument" },
					f = { "AroundFunction" },
					c = { "AroundClass " },
					o = { "AroundBlocks" },
					n = {
						a = { "nextAroundArgument" },
						f = { "nextAroundFunction" },
						c = { "nextAroundClass " },
						o = { "nextAroundBlocks" },
					},
				},
				a = {
					a = { "AroundArgument" },
					f = { "AroundFunction" },
					c = { "AroundClass " },
					o = { "AroundBlocks" },
					n = {
						name = "next",
						a = { "nextAroundArgument" },
						f = { "nextAroundFunction" },
						c = { "nextAroundClass " },
						o = { "nextAroundBlocks" },
					},
				},
			},
		})
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		require("which-key").setup({
			window = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
			key_labels = {
				-- override the label used to display some keys. It doesn't effect WK in any other way.
				-- For example:
				["<space>"] = "SPC",
				["<cr>"] = "RET",
				["<CR>"] = "RET",
				["<tab>"] = "TAB",
			},
		})
	end,
}
