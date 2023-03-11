return {
	defaults = {
		lazy = true,
	},
	--lua plugins that are other to use
	{ "nvim-lua/plenary.nvim", lazy = true },

	--icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	--undotree
	{ "mbbill/undotree", cmd = "UndotreeToggle" },

	-- impaitent
	{ "lewis6991/impatient.nvim" },

	--liveserver
	{ "manzeloth/live-server", cmd = "LiveServer start" },

	--lsp
	{ "onsails/lspkind.nvim", lazy = true },

	--tabstp
	{ "tpope/vim-sleuth", event = "InsertEnter" },

	-- autotag
	{ "windwp/nvim-ts-autotag", event = "TextChanged", ft = { "html", "css" } },
}
