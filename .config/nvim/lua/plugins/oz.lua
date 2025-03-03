return {
	"suvasanket/oz.nvim",
	dir = "~/codes/projects/oz-nvim",

	opts = {
		mappings = {
			Term = "<leader><cr>",
		},

		oil = {
			cur_entry_splitter = ":", -- this char will be used to define the pre and post of the entry
		},
		async_make = {
			override_make = false, -- override the default make cmd
		},
	},
}
