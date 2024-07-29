---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup({
	checker = {
		notify = false,
	},
	spec = {
		{ import = "plugins" },
		{ import = "plugins.misc" },
		{ import = "plugins.ui" },
		{ import = "plugins.edit" },
		{ import = "plugins.lsp&stuff" },
	},
	ui = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },

	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
