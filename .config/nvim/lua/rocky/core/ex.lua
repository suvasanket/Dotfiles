vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 2
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localrmdir = "rm -rf"

vim.api.nvim_create_autocmd("filetype", {
	pattern = "netrw",
	desc = "Better mappings for netrw",
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end
		bind("l", "<CR>")
		bind("h", "-")
		bind("i", "%")
		bind("<C-p>", ":bd<cr>")
	end,
})
