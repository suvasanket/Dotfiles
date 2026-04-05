vim.cmd([[
	set tabstop=4 shiftwidth=4 softtabstop=4 autochdir scrolloff=17
	packadd cfilter
	packadd nvim.undotree
	packadd nohlsearch
]])
vim.opt.inccommand = "split"
vim.opt.grepprg = "rg --vimgrep -u -S"
require("vim._core.ui2").enable()

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "snacks_picker_input" },
	callback = function()
		vim.b.minicompletion_disable = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "nvim-undotree", "help", "qf" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<cr>")
	end,
})
