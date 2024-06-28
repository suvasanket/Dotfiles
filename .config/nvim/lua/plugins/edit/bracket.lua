return {
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			--Config goes here
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "css", "eruby" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		keys = {
			{ "ys" },
			{ "yss" },
			{ "ds" },
			{ "cs" },
			{ "s", mode = "x" },
		},
		opts = {
			keymaps = {
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				viual = "s",
				visual_line = "s",
				delete = "ds",
				change = "cs",
			},
			aliases = {
				["<"] = ">",
				["b"] = { ")", "]", "}" },
				["q"] = { '"', "'", "`" },
				["s"] = { "}", "]", ")", ">", '"', "'", "`" },
			},
		},
	},
}
