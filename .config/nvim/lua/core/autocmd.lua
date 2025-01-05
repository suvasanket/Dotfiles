require("core.hilight")
require("core.buf_write")

-- Use 'q' to quit from common plugins
Autocmd("FileType", {
	pattern = {
		"help",
		"man",
		"lspinfo",
		"fugitive",
		"git",
		"qf",
		"noice",
		"vim",
	},
	callback = function(event)
		vim.cmd("setlocal listchars= nonumber norelativenumber")
		vim.opt_local.wrap = false
		vim.bo[event.buf].buflisted = false
		Map("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
		Map("n", "<esc>", "<cmd>noh<cr>", { buffer = event.buf, silent = true })
	end,
})

-- termclose
-- autocmd("TermClose", {
-- 	callback = function()
-- 		vim.cmd("close")
-- 	end
-- })

-- auto remove hidden buffers
Autocmd("BufHidden", {
	callback = function()
		vim.fn.timer_start(600000, function()
			vim.cmd("silent! BDelete hidden")
		end)
	end,
})

-- Persistent Cursor
Autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

--no auto comment
Autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.cmd("setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
	end,
})

--terminal win
Autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd("setlocal ma nonumber norelativenumber")
	end,
})

--luasnip auto insert templete
Augroup("SnippetAutoInsert", { clear = true })
Autocmd("BufNewFile", {
	group = "SnippetAutoInsert",
	pattern = "*/snippets/*.lua",
	callback = function()
		local boilerplate_path = "/Users/suvasanketrout/.config/nvim/snippets/boilerplate.lua"
		local content = vim.fn.readfile(boilerplate_path)

		vim.api.nvim_buf_set_lines(0, 0, -1, false, content)

		local filename = vim.fn.expand("%:t") -- Gets the tail of the filename
		local ext = vim.fn.fnamemodify(filename, ":r") -- Extracts the extension

		vim.cmd(':%s/"\\*\\.lua"/"\\*.' .. ext .. '"')
		vim.cmd("w")
		vim.cmd("e")
	end,
})

-- autocreate unavailable directory
Autocmd( "BufWritePre" , {
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
