return {
	"mrjones2014/smart-splits.nvim",
	--stylua: ignore
	keys = {
		{ "<C-left>", function() require("smart-splits").resize_left() end },
		{ "<C-down>", function() require("smart-splits").resize_down() end },
		{ "<C-up>", function() require("smart-splits").resize_up() end },
		{ "<C-right>", function() require("smart-splits").resize_right() end },
		-- moving between splits
		{ "<C-h>", function() require("smart-splits").move_cursor_left() end },
		{ "<C-j>", function() require("smart-splits").move_cursor_down() end },
		{ "<C-k>", function() require("smart-splits").move_cursor_up() end },
		{ "<C-l>", function() require("smart-splits").move_cursor_right() end },
		-- swapping buffers between windows
		{ "<leader><leader>h", function() require("smart-splits").swap_buf_left() end, desc = "swapLeft" },
		{ "<leader><leader>j", function() require("smart-splits").swap_buf_down() end, desc = "swapDown" },
		{ "<leader><leader>k", function() require("smart-splits").swap_buf_up() end, desc = "swapUp" },
		{ "<leader><leader>l", function() require("smart-splits").swap_buf_right() end, desc = "swapRight" },
	},
	opts = {},
}
