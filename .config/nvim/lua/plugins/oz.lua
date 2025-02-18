return {
	"suvasanket/oz.nvim",
	keys = { "<leader>a<cr>", "<leader>ac", "<leader>av", "<leader>at" },
	cmd = "Term",
    dir = "~/codes/projects/oz-nvim",
	dependencies = {
		"ej-shafran/compile-mode.nvim", -- optional
        "stevearc/oil.nvim", -- optional
	},
	opts = {
        mappings = {
            Term = "<leader>a<cr>"
        }
    },
}
