vim.cmd([[
	set tabstop=4 shiftwidth=4 softtabstop=4 autochdir scrolloff=17
	set nu relativenumber
	packadd cfilter
	packadd nvim.undotree
	packadd nohlsearch
]])
vim.opt.inccommand = "split"
vim.opt.grepprg = "rg --vimgrep -u -S"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "fff_input" },
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
