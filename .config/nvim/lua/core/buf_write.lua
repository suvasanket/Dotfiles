local notify = function(a)
    vim.notify(vim.fn.expand("%") .. a, vim.log.levels.INFO, { title = "BufWrite Post" })
end

-- lua source
BufWritePostFunc({ "*/ftplugin/*.lua", "*/lua/*.lua" }, function()
	vim.cmd("silent source")
    vim.notify(vim.fn.expand("%") .. " sourced", vim.log.levels.INFO, { title = "BufWrite Post"})
end)

-- tmux hot reload
BufWritePostFunc("tmux.conf", function()
	vim.cmd("silent !tmux source /Users/suvasanketrout/.config/tmux/tmux.conf")
	notify("reloaded")
end)

-- aerospace hot reload
BufWritePostFunc("aerospace.toml", function()
	vim.cmd("silent !aerospace reload-config")
	notify("reloaded")
end)

-- lualine hotreload
BufWritePostFunc("statusline.lua", function()
	vim.fn.timer_start(2000, function()
		vim.cmd("silent Lazy reload mini.statusline")
	end)
end)

BufWritePostFunc("karabiner-config.ts", function()
	vim.cmd("silent !./build.sh")
	notify("Updated")
end)
