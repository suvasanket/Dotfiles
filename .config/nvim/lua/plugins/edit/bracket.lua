return {
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		opts = {
			map_cr = true,
			map_bs = true,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "css" },
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
