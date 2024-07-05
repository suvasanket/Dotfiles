require("core.helper")

--HighLight
local hi = function(name, val, id)
	local defaultid = 0
	if id then
		defaultid = id
	end
	vim.api.nvim_set_hl(defaultid, name, val)
end
autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		hi("Folded", { fg = "#7D7C7C" })
		hi("Search", { link = "IncSearch" })

		hi("IlluminatedWordText", { link = "Visual" })
		hi("IlluminatedWordRead", { link = "Visual" })
		hi("IlluminatedWordWrite", { link = "Visual" })

		hi("TroubleNormal", { link = "Normal" })
		hi("TroubleNormalNC", { link = "Normal" })
		hi("hlyank", { bg = "#FF9B50" })
		hi("CmpItemAbbrMatchFuzzyDefault", { fg = "#F2613F" })
		hi("NormalFloat", { link = "Normal" })
		hi("FloatBorder", { bg = NONE })

		hi("TelescopeBorder", {  fg = "#272829", bg = "#222222" })
		hi("TelescopeNormal", {  bg = "#222222" })
		hi("TelescopePromptBorder", { link = "TelescopeBorder" })
		hi("TelescopeResultsBorder", { link = "TelescopeBorder" })
		hi("TelescopePreviewBorder", { link = "TelescopeBorder" })

		hi("Pmenu", { bg = "#222222" })
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
		"qf",
		"noice",
		"vim"
	},
	callback = function(event)
		vim.cmd("setlocal listchars= nonumber norelativenumber")
		vim.opt_local.wrap = false
		vim.bo[event.buf].buflisted = false
		map("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
		map("n", "<esc>", "<cmd>noh<cr>", { buffer = event.buf, silent = true })
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
		vim.cmd("setlocal nonumber norelativenumber")
		vim.cmd.startinsert()
	end,
})
-- autocmd("TermClose", {
-- 	group="term",
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd("setlocal number relativenumber")
-- 	end,
-- })

--insert mode
augroup("insrt", { clear = true })
autocmd("InsertEnter", {
	pattern = "*.*",
	group = "insrt",
	callback = function()
		vim.o.cursorline = false
	end,
})
autocmd("InsertLeave", {
	group = "insrt",
	pattern = "*.*",
	callback = function()
		vim.o.cursorline = true
	end,
})

--luasnip auto insert templete
augroup("SnippetAutoInsert", { clear = true })
autocmd("BufNewFile", {
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

--hotreload
augroup("hotreload", { clear = true })
autocmd("BufWritePost", {
	group = "hotreload",
	pattern = { "*/ftplugin/*.lua", "*/core/*.lua" },
	command = "silent source%",
})

autocmd("BufWritePost", {
	group = "hotreload",
	pattern = { "tmux.conf", "skhdrc", "yabairc", "statusline.lua", "aerospace.toml" },
	callback = function()
		local filename = vim.fn.expand("%")
		if filename == "tmux.conf" then
			vim.cmd("silent !tmux source /Users/suvasanketrout/.config/tmux/tmux.conf")
		elseif filename == "skhdrc" then
			vim.cmd("silent !skhd --restart-service")
		elseif filename == "yabairc" then
			vim.cmd("silent !yabai --restart-service")
		elseif filename == "aerospace.toml" then
			vim.cmd("silent !aerospace reload-config")
		end
	end,
})
