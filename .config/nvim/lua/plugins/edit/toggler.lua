return {
	"nguyenvukhang/nvim-toggler",
	keys = {
		{ "<leader>i", mode = { "n", "v" }, desc = "toggler" },
	},
	opts = {
		inverses = {
			["<"] = ">",
			["<="] = ">=",
			["=="] = "!=",
		},
	},
}
