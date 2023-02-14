vim.cmd([[colorscheme tokyonight]])
vim.cmd("highlight WinSeparator guibg=None")
vim.cmd("set guicursor=i:block")
vim.cmd("set syntax=off")
vim.cmd([[
hi Normal guibg=NONE ctermbg=NONE
]])
vim.api.nvim_command([[autocmd VimEnter * lua if vim.bo.filetype == 'startify' then
vim.cmd("Startify")
vim.cmd("IndentBlanklineDisable")
end]])
