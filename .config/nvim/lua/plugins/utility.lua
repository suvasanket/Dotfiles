return {
	--ClipBoard
	{
		"ibhagwan/smartyank.nvim",
		opts = {
			highlight = {
				timeout = 75,
			},
		},
	},

	--Treesj-Split join
	{
		"Wansmer/treesj",
		keys = { { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Split/Join" } },
		opts = {
			max_join_length = 220,
			notify = false,
		},
	},

	--sayonara
	{
		"mhinz/vim-sayonara",
		keys = {
			{ "<leader>q", "<cmd>Sayonara<cr>", desc = "Sayonara" },
			{ "<C-\\>", "<cmd>Sayonara!<cr>" },
		},
	},

	--Tmux
	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<M-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<M-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<M-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<M-l>", require("smart-splits").resize_right)
			-- moving between splits
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
			-- swapping buffers between windows
			vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
			vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
			vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
			vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
			require("smart-splits").setup({})
		end,
	},

	--Illuminate
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 300, modes_allowlist = { "n" }, min_count_to_highlight = 2 },
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},
}
