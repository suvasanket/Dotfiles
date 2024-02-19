--{{{
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local hl = function(name, val, id)
	local defaultid = 0
	if id then
		defaultid = id
	end
	vim.api.nvim_set_hl(defaultid, name, val)
end
--}}}

--HghLight
autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		-- hl("CursorLine", { blend = 3 })
		hl("DiagnosticFloatingInfo", { blend = 5 })
		hl("Folded", { fg = "#7D7C7C" })
		hl("Search", { link = "IncSearch" })
		hl("IlluminatedWordText", { link = "Visual" })
		hl("IlluminatedWordRead", { link = "Visual" })
		hl("IlluminatedWordWrite", { link = "Visual" })
		hl("hlyank", { bg = "#FF9B50" })
		hl("SignColumn", { fg = "NONE" })
	end,
})

--highlight yank
augroup("yank", { clear = true })
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "hlyank", timeout = 100 })
	end,
	group = "yank",
})

-- Use 'q' to quit from common plugins
autocmd("FileType", {
	pattern = {
		"help",
		"man",
		"lspinfo",
		"fugitive",
		"crunner",
		"qf",
		"noice",
	},
	callback = function(event)
		vim.cmd("setlocal listchars= nonumber norelativenumber")
		vim.opt_local.wrap = false
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Persistent Cursor
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

--no auto comment
autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.cmd("setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
	end,
})

--terminal win
autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd("setlocal listchars= nonumber norelativenumber")
		vim.cmd.startinsert()
	end,
})

--fugitive keymap
autocmd("FileType", {
	pattern = "fugitive",
	callback = function(event)
		vim.keymap.set("n", "P", "<cmd>Git push<cr>", { buffer = event.buf, silent = true })
		vim.keymap.set("n", "p", "<cmd>Git pull<cr>", { buffer = event.buf, silent = true })
	end,
})

--undotree
autocmd("FileType", {
	pattern = "undotree",
	callback = function()
		vim.cmd([[
		nmap <buffer> <C-p> <plug>UndotreeNextState
		nmap <buffer> <C-n> <plug>UndotreePreviousState
		]])
	end,
})

--insert mode
augroup("insrt", { clear = true })
autocmd("InsertEnter", {
	pattern = "*.*",
	group = "insrt",
	callback = function()
		vim.o.cursorline = true
	end,
})
autocmd("InsertLeave", {
	group = "insrt",
	pattern = "*.*",
	callback = function()
		vim.o.cursorline = false
	end,
})

--tabline
autocmd("FileType",{
	command="set showtabline=1"
})

--oil keymap
autocmd("FileType", {
	pattern = "oil",
	callback = function(event)
		vim.keymap.set("n", "<CR>", "<cmd>w<cr>", { buffer = event.buf, silent = true })
	end,
})
