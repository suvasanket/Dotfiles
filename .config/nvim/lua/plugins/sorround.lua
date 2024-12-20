return {
	"kylechui/nvim-surround",
	version = "*",
	keys = {
		{ "ys", mode = { "n", "x" } },
		{ "yss" },
		{ "ds" },
		{ "cs" },
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
}
