vim.cmd([[
	set tabstop=4 shiftwidth=4 softtabstop=4 autochdir scrolloff=17
	packadd cfilter
	packadd nvim.undotree
	packadd nohlsearch
]])
vim.opt.inccommand = "split"
vim.opt.grepprg = "rg --vimgrep -u -S"
