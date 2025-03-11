Import("core.buf_write")

-- Use 'q' to quit from common plugins
Autocmd("FileType", {
	pattern = {
		"help",
		"fugitive",
		"git",
		"qf",
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

-- autocreate unavailable directory
Autocmd("BufWritePre", {
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

--highlight yank
Augroup("yank", { clear = true })
Autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "CurSearch", timeout = 70 })
	end,
	group = "yank",
})

-- highligh override
-- Autocmd("VimEnter", {
-- 	pattern = "*",
-- 	callback = function()
--         vim.api.nvim_set_hl({ bg = "#FF9B50" }, "hlyank", {0})
-- 	end,
-- })
