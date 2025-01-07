local notify = function(a)
	Notify(vim.fn.expand("%"), nil, a)
end

-- lua source
BufWritePostFunc({ "*/ftplugin/*.lua", "*/lua/*.lua" }, function()
	if vim.fn.expand("%") == "abolish.lua" then
		vim.fn.timer_start(2000, function()
			vim.cmd("silent Lazy reload vim-abolish")
		end)
		notify("Abolised")
	else
		vim.cmd("silent source")
		notify("Sourced")
	end
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
