local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

-- all plugins
require("lazy").setup({
	defaults = {
		lazy = true,
	},
	--lua plugins that are other to use
	"nvim-lua/plenary.nvim",

	--theme
	"morhetz/gruvbox",
	"folke/tokyonight.nvim",

	--icons
	"nvim-tree/nvim-web-devicons",

	--scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "UiEnter",
		config = function()
			require("scrollbar").setup()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},

	--treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},

	-- auto closing
	"windwp/nvim-autopairs",
	{ "windwp/nvim-ts-autotag", event = "UiEnter", dependencies = "nvim-treesitter" },

	--code_runner
	{ "CRAG666/code_runner.nvim", dependencies = "nvim-lua/plenary.nvim", cmd = "RunCode" },

	--comment
	"numToStr/Comment.nvim",

	--startup screen
	"mhinz/vim-startify",

	--undotree
	{ "mbbill/undotree", cmd = "UndotreeToggle" },

	--transparent
	"xiyaowong/nvim-transparent",

	--indentation trail
	{ "lukas-reineke/indent-blankline.nvim", event = "BufEnter" },

	-- impaitent
	"lewis6991/impatient.nvim",

	--liveserver
	{ "manzeloth/live-server", cmd = "LiveServer start" },

	--cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
		},
	},

	--snippets
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	--lsp
	{ "jose-elias-alvarez/typescript.nvim", ft = "js" },
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"onsails/lspkind.nvim",

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",

	--vaffle
	{ "cocopon/vaffle.vim", dependencies = { "nvim-tree/nvim-web-devicons" } },

	--hl yank
	"machakann/vim-highlightedyank",

	--bufferline
	{ "akinsho/bufferline.nvim", event = "BufAdd" },

	--gitsigns
	{ "lewis6991/gitsigns.nvim", event = "UiEnter" },

	--fzf
	{ "junegunn/fzf", event = "UiEnter" },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = "0.1.1",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		opts = { defaults = { winblend = 18 } },
	},

	--vim-fugitive
	{ "tpope/vim-fugitive" },
})
