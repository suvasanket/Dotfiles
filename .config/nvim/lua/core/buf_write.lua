local notify = function(a)
	vim.notify(vim.fn.expand("%") .. " " .. a, vim.log.levels.INFO, { title = "BufWrite Post" })
end

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

BufWritePostFunc("karabiner-config.ts", function()
	vim.cmd("silent !./build.sh")
	notify("Updated")
end)
