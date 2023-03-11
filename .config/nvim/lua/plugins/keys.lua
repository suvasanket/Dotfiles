return {
	"folke/which-key.nvim",
	event = "UiEnter",
	keys = {
		--general
		{ "<C-\\>", "<C-\\><C-n><cmd>bd!<cr>", mode = "t" },
		{ "<C-c>", "<ESC>", mode = "t" },
		{ "<C-c>", "<ESC>", mode = "v" },
		{ "<leader>r", '<cmd>source %<cr> <cmd>echo"sourced"<cr>', desc = "source" },
		{ "<leader>w", "<cmd>wa!<cr>" },
		{ "<leader>l", "<cmd>Lazy<cr>", desc = "Lazy" },
		{ "<leader>t", "<cmd>Lspsaga term_toggle<cr>", desc = "FloatTerm" },
		{ "<leader>c", "<cmd>Codeium Enable<cr> <cmd>echo 'Codeium Enabled'<cr>", desc = "Codeium Enable" },

		--splits
		{ "<leader>-", "<C-w>s", desc = "-Split" },
		{ "<leader>|", "<C-w>v", desc = "|Split" },
		{ "<leader>=", "<C-w>=", desc = "EqualizeSplit" },
		{ "<leader>sm", "<C-w>m", desc = "SplitMaximise" },

		--buffer & tab
		{ "<tab>h", "<cmd>tabprevious<cr>" },
		{ "<tab>l", "<cmd>tabnext<cr>" },
		{ "<tab>q", "<cmd>tabclose<cr>" },
		{ "<C-]>", "<cmd>bnext<CR>" },
		{ "<C-[>", "<cmd>bprevious<CR>" },

		--advanced keymaps
		{ "<leader>p", '"_dp', desc = "PasteWithoutCoping" },

		--runner
		{ "<leader>o", "<cmd>RunCode<CR>" },
		{ "<leader>rf", "<cmd>RunFile<CR>" },
		{ "<leader>rp", "<cmd>RunProject<CR>" },
		{ "<leader>crf", "<cmd>CRFiletype<CR>" },
		{ "<leader>crp", "<cmd>CRProjects<CR>" },

		--undotree
		{ "<leader>u", "<cmd>UndotreeToggle<cr> :UndotreeFocus<cr>", desc = "UndoTree" },

		--live server
		{ "<leader>ls", "<cmd>LiveServer start<cr>" },
		{ "<leader>le", "<cmd>LiveServer stop<cr>" },

		--git
		{ "<leader>gi", ":Git init<cr>" },
		{ "<leader>grm", ":Git rm<cr>" },
		{ "<leader>gd", ":Gdiffsplit<cr>" },
		{ "<leader>gu", ":Gread<cr>" },
		{ "<leader>gp", ":Git<cr>" },
		{ "<leader>gs", "<cmd>Gitsigns stage_buffer<cr>", desc = "GitStage" },
		{ "<leader>g0", "<cmd>Gitsigns reset_buffer_index<cr>", desc = "GitReset" },
		{ "<leader>ga", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Blame" },
		{ "<C-g>", "<cmd>LazyGit<cr>" },
	},
	config = function()
		local wk = require("which-key")
		wk.register({
			["v"] = {
				i = {
					a = { "InsideArgument" },
					f = { "InsideFunction" },
					c = { "InsideClass " },
					o = { "InsideBlocks" },
					n = {
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
		require("which-key").setup({})
	end,
}
